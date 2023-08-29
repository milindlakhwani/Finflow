import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/utils.dart';
import 'package:finflow_iot/features/auth/repository/auth_repository.dart';
import 'package:finflow_iot/features/auth/screens/otp_page.dart';
import 'package:finflow_iot/features/auth/screens/signup_page.dart';
import 'package:finflow_iot/features/home/screens/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(false);

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    state = true;
    final check = await _authRepository.signInWithPhone(context, phoneNumber);
    state = false;
    // l means left i.e the error, and r means right meaning Success.
    check.fold(
      (l) => showToast(l.message),
      (res) async {
        if (res == AuthState.auth) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('number', phoneNumber);
          if (context.mounted) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
          }
        } else {
          Navigator.of(context)
              .pushNamed(OTPPage.routeName, arguments: phoneNumber);
        }
      },
    );
  }

  void verifyOtp({
    required String userOtp,
    required BuildContext context,
  }) async {
    state = true;

    final check = await _authRepository.verifyOtp(userOtp: userOtp);
    state = false;

    check.fold(
      (l) => showToast(l.message),
      (userCreds) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('number', userCreds.user!.phoneNumber!);
        if (context.mounted) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        }
      },
    );
  }

  void signOut(BuildContext context) {
    _authRepository.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil(SignUpPage.routeName, (route) => false);
  }
}
