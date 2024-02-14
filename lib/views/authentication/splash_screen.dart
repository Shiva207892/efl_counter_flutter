import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    userController.getUserData();

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('User is: ${userController.isLoggedIn.isTrue ? 'Login' : 'Logout'}'),
                Text('User ID: ${userController.userId.value}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
