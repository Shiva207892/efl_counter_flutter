import 'package:efl_counter/common/get_storage.dart';
import 'package:efl_counter/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../common/custom_toast.dart';
import '../../common/route_helper.dart';
import '../../controllers/user_controller.dart';

getOtp() async {
  String? phoneNumber = getString(Constants.USER_PHONE_NUMBER);

  if (phoneNumber != null) {
    String phone = '+91$phoneNumber';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        setData(
            Constants.USER_PHONE_VERIFICATION_ID, credential.verificationId!);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Toast.error('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationid, int? resendtoken) {
        setData(Constants.USER_PHONE_VERIFICATION_ID, verificationid);
        Future.delayed(Duration.zero, () => Get.toNamed(RouteHelper.otp));
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        Toast.error('Code retrieval timed out.....');
      },
    );
  }
}

Future<void> verifyOTPCode(String loginOtp) async {
  print('otp is$loginOtp');

  String? loginVerificationId = getString(Constants.USER_PHONE_VERIFICATION_ID);
  print('vvvvvv: $loginVerificationId');

  if (loginVerificationId != null) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: loginVerificationId,
      smsCode: loginOtp,
    );

    print(credential);

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
        Get.offAllNamed(RouteHelper.splash);
      } catch (e) {
        if (kDebugMode) {
          print('Error: $e');
        }
      }
    });
  }
}
