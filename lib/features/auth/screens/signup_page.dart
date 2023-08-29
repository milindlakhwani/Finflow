import 'package:finflow_iot/core/common/loader.dart';
import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:finflow_iot/core/globals/my_spaces.dart';
import 'package:finflow_iot/core/globals/size_config.dart';
import 'package:finflow_iot/core/utils.dart';
import 'package:finflow_iot/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class SignUpPage extends ConsumerWidget {
  SignUpPage({super.key});
  static const String routeName = '/signup';
  static final _formKey = GlobalKey<FormState>();
  String _phoneNumber = "";

  void onSave(BuildContext context, WidgetRef ref) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    ref
        .read(authControllerProvider.notifier)
        .signInWithPhone(context, _phoneNumber);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().init(context);
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: getAppBar(),
      // appBar: AppBar(
      //   toolbarHeight: SizeConfig.screenHeight / 10,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: SvgPicture.asset(
      //       'assets/icons/Logo.svg',
      //     ),
      //   ),
      //   title: Text(
      //     'Finflow',
      //     style: MyFonts.medium,
      //   ),
      // ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: SizeConfig.verticalBlockSize * 7.5,
                  ),
                  Image.asset(
                    Constants.signUpPageImage,
                    width: SizeConfig.horizontalBlockSize * 90,
                  ),
                  Text(
                    'Welcome to Finflow!',
                    style: MyFonts.medium.setColor(Colors.black45).size(17),
                  ),
                  MySpaces.vGapInBetween,
                  TextFormField(
                    initialValue: _phoneNumber,
                    decoration: getDecoration(
                      "Enter Phone Number",
                      const Color(0xFFF3F9FF),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return "Phone number cannot be empty";
                      }
                      if (value!.length != 10) {
                        return "Phone number should be of 10 characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phoneNumber = "+91${value!}";
                    },
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),
                  MySpaces.vLargeGapInBetween,
                  isLoading
                      ? const Loader()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => onSave(context, ref),
                          child: Text(
                            'Next',
                            style: MyFonts.medium.size(18),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
