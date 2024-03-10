import 'package:efl_counter/common/custom_toast.dart';
import 'package:efl_counter/common/get_storage.dart';
import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/login_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/app_constants.dart';
import 'package:efl_counter/utils/app_pictures.dart';
import 'package:efl_counter/views/authentication/phone_authentication_methods.dart';
import 'package:efl_counter/widgets/base_gradient.dart';
import 'package:efl_counter/widgets/custom_button.dart';
import 'package:efl_counter/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/dimensions.dart';
import '../../widgets/auth_top_image.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final loginController = Get.put(LoginController());

  var phoneController = TextEditingController();

  var agreeText = poppinsRegular;
  var underLinedText = poppinsBold.copyWith(
      color: Colors.orange.shade400,
      fontSize: Dimensions.fontSizeLarge,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.clear();
  }

  void submit() {
    if (phoneController.text.length == 10) {
      showCustomDialogTwoActioned(
          context,
          'We will be verifying the phone number:',
          '+91 ${phoneController.text}\n\n Is this OK, or would you like to edit the number?',
          'CONFIRM', () {
            setData(Constants.USER_PHONE_NUMBER, phoneController.text);
        Get.back();
        loginController.isOtpRequested.value = true;
        getOtp();
      }, 'EDIT', () => Get.back());
    } else {
      Toast.error('Enter complete phone number please');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        style: poppinsRegular.copyWith(
                            fontSize: Dimensions.fontSizeLargest,
                            color: Colors.white)),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text('Enter your mobile number to continue.',
                        style: poppinsRegular.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeLarge,
                            fontWeight: FontWeight.w300)),
                    const SizedBox(height: Dimensions.paddingSizeLargest),
                    Obx(
                      () => CustomTextField(
                          controller: phoneController,
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
}