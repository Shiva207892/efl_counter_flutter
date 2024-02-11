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

  // @override
  // void dispose() {
  //   pinController.dispose();
  //   focusNode.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final focusNode = FocusNode();
    // final formKey = GlobalKey<FormState>();

    const focusedBorderColor = Color.fromRGBO(255, 255, 255, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(171, 171, 171, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
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
                        Text('OTP Verification', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeLargest, color: Colors.white)),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Enter OTP sent to your\nmobile number xxxxxx833', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeLarge, color: Colors.white, fontWeight: FontWeight.w300)),
                        const SizedBox(height: Dimensions.paddingSizeLargest),

                        Pinput(
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          validator: (s) {
                            return s == '2222' ? null : 'Pin is incorrect';
                          },
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          onCompleted: (pin) => print(pin),
                        ),

                        Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                            child: CustomButton(buttonText: 'SUBMIT', onTap: () {
                              print('submit otp');
                              Get.toNamed('/profile');
                            })),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
