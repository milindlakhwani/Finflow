import 'package:finflow_iot/core/common/loader.dart';
import 'package:finflow_iot/core/constants/constants.dart';
import 'package:finflow_iot/core/globals/my_fonts.dart';
import 'package:finflow_iot/core/globals/my_spaces.dart';
import 'package:finflow_iot/core/globals/size_config.dart';
import 'package:finflow_iot/core/utils.dart';
import 'package:finflow_iot/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OTPPage extends ConsumerStatefulWidget {
  static const String routeName = '/otp';

  const OTPPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage> {
  static final _formKey = GlobalKey<FormState>();
  String? _otp;

  void onSave(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    ref.read(authControllerProvider.notifier).verifyOtp(
          userOtp: _otp!,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: getAppBar(wantLeading: false),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Constants.otpPageImage,
                    width: SizeConfig.horizontalBlockSize * 90,
                  ),
                  MySpaces.vGapInBetween,
                  Text(
                    'Welcome to Finflow!',
                    style: MyFonts.medium.setColor(Colors.black45).size(17),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    decoration: getDecoration(
                      "Enter OTP",
                      const Color(0xFFF3F9FF),
                    ),
                    validator: (value) {
                      if (value == "") {
                        return "Enter the otp";
                      }
                      if (value!.length < 6) {
                        return "OTP minimum length is 6";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _otp = value!;
                    },
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),
                  MySpaces.vGapInBetween,
                  isLoading
                      ? const Loader()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => onSave(context),
                          child: Text(
                            'Next',
                            style: MyFonts.medium.size(18),
                          ),
                        ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'A 6 digit code has been sent to ',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black45),
                      children: [
                        TextSpan(
                          text: ModalRoute.of(context)?.settings.arguments
                              as String, //mobileNumber.substring(0, 3) + ' ' + mobileNumber.substring(3),
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        )
                      ],
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
