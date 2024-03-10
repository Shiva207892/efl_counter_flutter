

import 'package:efl_counter/common/get_storage.dart';
import 'package:efl_counter/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../common/custom_toast.dart';
import '../../common/route_helper.dart';
import '../../controllers/login_controller.dart';

getOtp() async {
  String? phoneNumber = getString(Constants.USER_PHONE_NUMBER);
  final loginController = Get.find<LoginController>();

  if(phoneNumber != null) {

    String phone = '+91$phoneNumber';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        loginController.loginOtp.value = credential.smsCode!;
        loginController.loginVerificationId.value = credential.verificationId!;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Toast.error('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationid, int? resendtoken) {
        loginController.loginVerificationId.value = verificationid;
        Get.toNamed(RouteHelper.otp);
      },
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {
        Toast.error('Code retrieval timed out.....');
      },
    );
  }
}