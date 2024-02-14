import 'package:efl_counter/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> fNameController = TextEditingController().obs;
  Rx<TextEditingController> lNameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  @override void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getProfileData() async {
    final userController = Get.find<UserController>();
    fNameController.value.text = userController.userFirstName.value;
    lNameController.value.text = userController.userLastName.value;
    phoneController.value.text = userController.userPhone.value;
    emailController.value.text = userController.userEmail.value;
  }
}