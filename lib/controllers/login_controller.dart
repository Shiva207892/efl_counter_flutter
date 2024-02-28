import 'package:efl_counter/common/custom_toast.dart';
import 'package:efl_counter/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginController extends GetxController {
  RxBool isOtpRequested = false.obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;

  RxString loginOtp = '000000'.obs;
  RxString loginVerificationId = 'verificationid'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getOTP();
  }

  Future<void> _getOTP() async {
    if (kDebugMode) {
      print('sending otp');
    }
    await SmsAutoFill().listenForCode();
  }

  Future<void> verifyOTPCode(BuildContext context) async {
    if (kDebugMode) {
      print('verification id is: $loginVerificationId');
    }

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: loginVerificationId.value,
      smsCode: loginOtp.value,
    );

    FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      if (kDebugMode) {
        Toast.success('User logged in successfully');
      }
      try {
        if (kDebugMode) {
          print('User is: $value');
          print('Is user new: ${value.additionalUserInfo?.isNewUser}');
        }

        if ('${value.additionalUserInfo?.isNewUser}' == 'true') {
          await Get.find<UserController>().addUserData();
        }
        Get.toNamed('/splash');
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    });
  }
}