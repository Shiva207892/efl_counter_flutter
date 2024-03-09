import 'package:efl_counter/common/route_helper.dart';
import 'package:efl_counter/controllers/login_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/app_pictures.dart';
import 'package:efl_counter/widgets/base_gradient.dart';
import 'package:efl_counter/widgets/custom_button.dart';
import 'package:efl_counter/widgets/custom_dialog.dart';
import 'package:efl_counter/widgets/custom_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/dimensions.dart';
import '../../widgets/auth_top_image.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());

    var agreeText = GoogleFonts.inter(
        color: Colors.white54,
        fontSize: Dimensions.fontSizeDefault,
        fontWeight: FontWeight.w300);
    var underLinedText = GoogleFonts.inter(
        color: Colors.orange.shade400,
        fontSize: Dimensions.fontSizeLarge,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline);

    void submit() {
      if (loginController.phoneController.value.text.length == 10) {
        showCustomDialogTwoActioned(
            context,
            'We will be verifying the phone number:',
            '+91 ${loginController.phoneController.value.text}\n\n Is this OK, or would you like to edit the number?',
            'CONFIRM', () {
          Navigator.of(context).pop();
          loginController.isOtpRequested.value = true;
          getOtp(context, loginController.phoneController.value.text);
        }, 'EDIT', () => Navigator.of(context).pop());
      } else {
        showCustomSnackbar(
            title: 'Error',
            message: 'Enter complete phone number please',
            duration: const Duration(seconds: 1));
      }
    }

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
                    Text('Login',
                        style: GoogleFonts.inter(
                            fontSize: Dimensions.fontSizeLargest,
                            color: Colors.white)),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text('Enter your mobile number to continue.',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w300)),
                    const SizedBox(height: Dimensions.paddingSizeLargest),
                    Obx(
                      () => CustomTextField(
                          controller: loginController.phoneController.value,
                          enabled: loginController.isOtpRequested.isFalse,
                          hintText: 'Enter your mobile number',
                          prefixImage: AppPictures.phoneIcon,
                          keyboard: TextInputType.phone,
                          maxLength: 10,
                          fillColor: Colors.white),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Obx(
                      () => loginController.isOtpRequested.isTrue
                          ? const CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            )
                          : CustomButton(buttonText: 'Verify', onTap: submit),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1)
                  ],
                ),
              )
            ],
          ),
        ),
      )),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //     Text('By continue you agree to our privacy & terms and conditions.',
      //         style: agreeText),
      //
      //     Row(
      //       children: [
      //         Text('I agree with ', style: agreeText),
      //         InkWell(
      //             onTap: () {
      //               if(!isOtpRequested){
      //                 Get.toNamed('/privacy_policy');
      //               }
      //             },
      //             child:
      //             Text('Privacy Policy', style: underLinedText))
      //       ],
      //     ),
      //     Row(
      //       children: [
      //         Text('I agree with ', style: agreeText),
      //         InkWell(
      //             onTap: () {
      //               if(!isOtpRequested) {
      //                 Get.toNamed('/terms_conditions');
      //               }
      //             },
      //             child: Text('Terms & Conditions',
      //                 style: underLinedText))
      //       ],
      //     ),
      //   ],),
      // ),
    );
  }

  getOtp(BuildContext context, String phoneNumber) async {
    final loginController = Get.find<LoginController>();

    String phone = '+91$phoneNumber';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        loginController.loginOtp.value = credential.smsCode!;
        loginController.loginVerificationId.value = credential.verificationId!;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          showCustomSnackbar(
              title: 'Invalid Number',
              message: 'The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationid, int? resendtoken) {
        loginController.loginVerificationId.value = verificationid;
        Get.toNamed(RouteHelper.otp);
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Code retrieval timed out.....');
      },
    );
  }
}