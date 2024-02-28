import 'package:efl_counter/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/auth_top_image.dart';
import '../../widgets/base_gradient.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    final pinController = TextEditingController();

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

    pinController.text = loginController.loginOtp.value;

    return WillPopScope(
      onWillPop: () async {
        loginController.isOtpRequested.value = false;
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
                          style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeLargest,
                              color: Colors.white70)),
                      const SizedBox(height: Dimensions.paddingSizeLargest),
                      Text(
                          'Enter OTP sent to your\nmobile number xxxxxxx${loginController.phoneController.value.text.substring(7)}',
                          style: GoogleFonts.inter(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Colors.white60,
                              fontWeight: FontWeight.w300)),
                      const SizedBox(height: Dimensions.paddingSizeLargest),
                      Pinput(
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        validator: (s) {
                          return s?.length == 6 ? null : 'OTP is Incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) =>
                            loginController.loginOtp.value = pin,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2),
                          child: CustomButton(
                              buttonText: 'SUBMIT',
                              onTap: () =>
                                  loginController.verifyOTPCode(context))),
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
