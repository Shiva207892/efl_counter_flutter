import 'package:efl_counter/utils/dimensions.dart';
import 'package:efl_counter/widgets/base_gradient.dart';
import 'package:efl_counter/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/app_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/profile_image.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var normalFontStyle = GoogleFonts.inter(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: Dimensions.fontSizeDefault);

    return WillPopScope(
      onWillPop: () async {
        Get.find<AppController>().setCurrentPageIndex(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
            child: baseGradientContainer(
                context,
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(Dimensions.paddingSizeLargest),
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeLargest),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.91,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          'My Profile',
                          style: GoogleFonts.inter(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimensions.fontSizeExtraLarge),
                        )),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        profileImage(120, true),
                        Text('First Name', style: normalFontStyle),
                        const CustomTextField(enabled: true,
                            hintText: 'First Name', keyboard: TextInputType.name),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Last Name', style: normalFontStyle),
                        Text('Email Address', style: normalFontStyle),
                        Text('Phone Number', style: normalFontStyle),
                        const Text('State'),
                        const Text('City'),
                        CustomButton(
                            buttonText: 'Update Profile',
                            onTap: () {
                              print('update profile');
                              Get.toNamed('/home');
                            })
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
