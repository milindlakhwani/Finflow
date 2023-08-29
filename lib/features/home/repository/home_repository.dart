import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/failure.dart';
import 'package:finflow_iot/core/providers/firebase_providers.dart';
import 'package:finflow_iot/core/type_defs.dart';
import 'package:finflow_iot/features/notifications/notification_provider.dart';
import 'package:finflow_iot/models/sensor_val.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

final homeRepositoryProvider = Provider(
  (ref) => HomeRepository(
    db: ref.read(dbProvider),
    firestore: ref.read(firestoreProvider),
    ref: ref,
  ),
);

class HomeRepository {
  final DatabaseReference _db;
  final firestore.FirebaseFirestore _firestore;
  final Ref _ref;

  HomeRepository(
      {required DatabaseReference db,
      required firestore.FirebaseFirestore firestore,
      required Ref ref})
      : _db = db,
        _firestore = firestore,
        _ref = ref;

  firestore.CollectionReference get _products =>
      _firestore.collection(Constants.productsCollection);

  String? productId;

  Future<bool> hasExistingID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('id');
    productId = id;
    return (id != null);
  }

  void storeNewId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    productId = id;

    String? token = await _ref.read(notificationProvider).getToken();

    if (token != null) {
      await _products.doc(productId).collection("tokens").doc(token).set({});
    }

    // prefs.setString('id', "ID1");
    prefs.setString('id', id);
  }

  FutureEither<SensorVal> fetchLatestData() async {
    try {
      final response = await _db.child(productId!).get();

      return right(SensorVal.fromMap(response.value as Map<dynamic, dynamic>));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure("Error fetching data! Please try later"));
    }
  }

  Query getChanges() {
    return _db.child(productId!);
  }

  FutureVoid requestTest() async {
    try {
      return right(await _db.child(productId!).update({'performTest': true}));
    } on FirebaseException catch (e) {
      return left(Failure(e.toString()));
    } catch (e) {
      return left(Failure("Sending request failed! Please try again later"));
    }
  }

  Future<void> callOffRequest() async {
    await Future.delayed(const Duration(seconds: 2));
    await _db.child(productId!).update({'performTest': false});
  }
}
