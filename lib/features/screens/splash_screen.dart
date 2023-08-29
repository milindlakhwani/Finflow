import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:finflow_iot/core/globals/size_config.dart';
import 'package:finflow_iot/features/auth/screens/signup_page.dart';
import 'package:finflow_iot/features/home/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void initialize(BuildContext context) {
    String? phoneNum;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      phoneNum = prefs.getString('number');
      if (context.mounted) {
        if (phoneNum == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(SignUpPage.routeName, (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    initialize(context);
    return Scaffold(
      body: Center(
        child: Text(
          "FinFlow",
          style: MyFonts.bold.factor(15).setColor(const Color(0xFF23286B)),
        ),
      ),
    );
  }
}
