import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:finflow_iot/core/globals/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

InputDecoration getDecoration(String hint, Color color) {
  return InputDecoration(
    filled: true,
    fillColor: color,
    hintText: hint,
    contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

void showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

AppBar getAppBar(
    {bool wantLeading = true, List<Widget> appBarActions = const []}) {
  return AppBar(
    toolbarHeight: SizeConfig.screenHeight / 10,
    leading: wantLeading
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/icons/Logo.svg',
            ),
          )
        : null,
    title: Text(
      'Finflow',
      style: MyFonts.medium,
    ),
    actions: appBarActions,
  );
}
