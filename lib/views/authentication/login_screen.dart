import 'package:efl_counter_flutter/utils/app_colors.dart';
import 'package:efl_counter_flutter/utils/app_pictures.dart';
import 'package:efl_counter_flutter/widgets/base_gradient.dart';
import 'package:efl_counter_flutter/widgets/custom_button.dart';
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
    FocusNode currentNode = FocusNode();

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
                    Text('Login', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeLargest, color: Colors.white)),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Text('Enter your mobile number to continue.', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeLarge, color: Colors.white, fontWeight: FontWeight.w300)),
                    const SizedBox(height: Dimensions.paddingSizeLargest),
                    CustomTextField(focusNode: currentNode, hintText: 'Enter your mobile number', prefixImage: AppPictures.phoneIcon),
                    Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                        child: CustomButton(buttonText: 'Verify', onTap: () {
                          print('verify phhone');
                          Get.toNamed('/otp');
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