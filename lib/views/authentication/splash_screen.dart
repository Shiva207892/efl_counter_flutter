import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/user_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    userController.getUserData();

    return const Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Colors.green)
              ],
            ),
        ),
      ),
    );
  }
}
