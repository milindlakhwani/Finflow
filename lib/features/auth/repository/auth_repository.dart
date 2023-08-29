import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/failure.dart';
import 'package:finflow_iot/core/providers/firebase_providers.dart';
import 'package:finflow_iot/core/type_defs.dart';
import 'package:finflow_iot/features/notifications/notification_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: ref.read(authProvider),
    ref: ref,
    firestore: ref.read(firestoreProvider),
  ),
);

class AuthRepository {
  final FirebaseAuth _auth;
  final Ref _ref;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseAuth auth,
    required Ref ref,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _ref = ref,
        _firestore = firestore;

  late String _verificationId;

  CollectionReference get _products =>
      _firestore.collection(Constants.productsCollection);

  FutureEither<AuthState> signInWithPhone(
      BuildContext context, String phoneNumber) async {
    try {
      AuthState res = AuthState.auth;
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
          res = AuthState.auth;
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          _verificationId = verificationId;
          res = AuthState.verify;
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );

      return right(res);
    } on FirebaseAuthException catch (e) {
      return left(Failure(e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserCredential> verifyOtp({
    required String userOtp,
  }) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: userOtp,
      );
      return right(await _auth.signInWithCredential(creds));
    } on FirebaseAuthException catch (error) {
      if (error.code == 'invalid-verification-code') {
        return left(Failure("Entered otp is incorrect"));
      } else if (error.code == 'network-request-failed') {
        return left(Failure(
            "Error connecting to the server\nMake sure internet is turned on"));
      } else if (error.code == 'invalid-verification-id') {
        return left(Failure("Error verifying OTP! Please try again."));
      }
      rethrow;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await _ref.read(notificationProvider).getToken();
    String? id = prefs.getString('id');

    if (token != null && id != null) {
      await _products.doc(id).collection("tokens").doc(token).set({});
    }
    prefs.clear();
    await _auth.signOut();
  }
}
