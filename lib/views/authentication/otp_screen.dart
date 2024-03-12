import 'package:efl_counter/common/get_storage.dart';
import 'package:efl_counter/utils/app_constants.dart';
import 'package:efl_counter/views/authentication/phone_authentication_methods.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import '../../common/styles.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/auth_top_image.dart';
import '../../widgets/base_gradient.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? phoneNumber;
  final pinController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phoneNumber = getString(Constants.USER_PHONE_NUMBER);
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
            child: baseGradientContainer(
          context,
          SingleChildScrollView(
            child: Column(
              children: [
                authTopImage(context),
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeLargest),
                  child: Column(
                    children: [
                      Text('OTP Verification',
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeLargest,
                              color: Colors.white70)),
                      const SizedBox(height: Dimensions.paddingSizeLargest),
                      Text(
                          'Enter OTP sent to your\nmobile number xxxxxxx${phoneNumber?.substring(7)}',
                          style: poppinsRegular.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Colors.white60,
                              fontWeight: FontWeight.w300)),
                      const SizedBox(height: Dimensions.paddingSizeLargest),
                      Pinput(
                        length: 6,
                        controller: pinController,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        validator: (s) {
                          return s?.length == 6 ? null : 'OTP is Incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => print(pin)
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2),
                          child: CustomButton(
                              buttonText: 'SUBMIT',
                              onTap: () {
                                var loginOtp = pinController.text;
                                print(loginOtp);
                                verifyOTPCode(loginOtp);
                              })),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}