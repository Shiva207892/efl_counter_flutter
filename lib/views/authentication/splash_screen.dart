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
    wait(userController);
    return const Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primaryColor)
            ],
          ),
        ),
      ),
    );
  }

  void wait(UserController userController) async {
    await userController.checkUser();
    if (userController.isUser.isFalse) {
      Get.offAllNamed(RouteHelper.login);
    } else {
      if (userController.userStatus.value == 'Pending') {
        Get.offAllNamed(RouteHelper.profile);
      }
      if (userController.userStatus.value == 'Approved') {
        Get.offAllNamed(RouteHelper.home);
      }
    }
  }
}
