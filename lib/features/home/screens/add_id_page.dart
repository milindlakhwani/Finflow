import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AddIdPage extends ConsumerWidget {
  const AddIdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            Constants.notFoundLottie,
            repeat: true,
            animate: true,
          ),
          Text(
            "No Device Found",
            style: MyFonts.bold.size(20),
          ),
          Text(
            "Start by adding a new device",
            style: MyFonts.medium.size(13).setColor(Colors.black),
          ),
        ],
      ),
    );
  }
}
