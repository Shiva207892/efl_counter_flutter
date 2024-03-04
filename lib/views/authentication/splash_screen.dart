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
          if (Get.currentRoute != '/profile') {
            Get.offAllNamed(
              '/profile',
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
          if (Get.currentRoute != '/home') {
            Get.offAllNamed('/home');
          }
        }
      } else {
        Get.offAllNamed('/login');
      }
    });

    return const Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CircularProgressIndicator(color: Colors.green)],
          ),
        ),
      ),
    );
  }
}
