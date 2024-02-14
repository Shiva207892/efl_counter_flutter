import 'package:efl_counter/controllers/profile_controller.dart';
import 'package:efl_counter/controllers/user_controller.dart';
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
    final userController = Get.find<UserController>();
    final profileController = Get.find<ProfileController>();

    profileController.getProfileData();

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
                        userController.userStatus.value == 'pending'
                            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () => userController.logoutUser(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(
                                          Dimensions.paddingSizeDefault),
                                      child: Text('Logout',
                                          style: GoogleFonts.inter(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: Dimensions.fontSizeDefault)),
                                    ),
                                  ),
                                Text('Pending',
                                    style: GoogleFonts.inter(
                                        color: AppColors.pendingColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeDefault))
                              ],
                            )
                            : const SizedBox(),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        profileNameImage(120, true),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Phone', style: normalFontStyle),
                        Obx(
                          () => CustomTextField(
                              enabled: false,
                              controller:
                                  profileController.phoneController.value,
                              hintText: 'Phone',
                              keyboard: TextInputType.number),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('First Name', style: normalFontStyle),
                        Obx(
                          () => CustomTextField(
                              enabled: true,
                              controller:
                                  profileController.fNameController.value,
                              hintText: 'First Name',
                              keyboard: TextInputType.name),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Last Name', style: normalFontStyle),
                        Obx(
                          () => CustomTextField(
                              enabled: true,
                              controller:
                                  profileController.lNameController.value,
                              hintText: 'Last Name',
                              keyboard: TextInputType.name),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Email Address', style: normalFontStyle),
                        Obx(
                          () => CustomTextField(
                              enabled: true,
                              controller:
                                  profileController.emailController.value,
                              hintText: 'Email Address',
                              keyboard: TextInputType.emailAddress),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        const Text('State'),
                        const Text('City'),
                        CustomButton(
                            buttonText: 'Update Profile',
                            onTap: () {
                              print('update profile');
                              Get.toNamed('/home');
                            }),
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
