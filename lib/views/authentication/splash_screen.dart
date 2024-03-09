import 'package:efl_counter/common/route_helper.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    userController.getUserData().then((value) {
      if (value == true) {
        if (userController.userStatus.value == 'Pending') {
          print('current   ${Get.currentRoute}');
          if (Get.currentRoute != RouteHelper.profile) {
            Get.offAllNamed(
              RouteHelper.profile,
              parameters: {
                'phone': userController.userPhone.value,
                'photo': userController.userPhoto.value,
                'status': userController.userStatus.value,
                'firstName': userController.userFirstName.value,
                'lastName': userController.userLastName.value,
                'email': userController.userEmail.value,
                'address': userController.userAddress.value,
              },
            );
          }
        } else {
          if (Get.currentRoute != RouteHelper.home) {
            Get.offAllNamed(RouteHelper.home);
          }
        }
      } else {
        Get.offAllNamed(RouteHelper.login);
      }
    });

    return const Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator(color: AppColors.primaryColor)],
          ),
        ),
      ),
    );
  }
}
