import 'package:efl_counter/controllers/user_controller.dart';
import 'package:efl_counter/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/styles.dart';
import '../../controllers/app_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/base_gradient.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final appController = Get.find<AppController>();
  final userController = Get.find<UserController>();

  final phoneController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();

    phoneController.text = userController.userPhone.value;
    fNameController.text = userController.userFirstName.value;
    lNameController.text = userController.userLastName.value;
    emailController.text = userController.userEmail.value;
    addressController.text = userController.userAddress.value;
  }

  @override
  void dispose() {
    fNameController.dispose();
    lNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var normalFontStyle = poppinsRegular.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: Dimensions.fontSizeDefault);

    return WillPopScope(
      onWillPop: () async {
        appController.setCurrentPageIndex(0);
        if(userController.userStatus.value == 'Pending') {
          return true;
        }
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
                padding: const EdgeInsets.all(Dimensions.paddingSizeLargest),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.91,
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    userController.userStatus.value == 'Pending'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => userController.logoutUser(),
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeDefault),
                                  child: Text('Logout',
                                      style: poppinsRegular.copyWith(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: Dimensions.fontSizeDefault)),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (userController.userStatus.value ==
                                      'Pending') {
                                    showCustomSnackbar(
                                        title: 'Confirmation Pending:',
                                        message:
                                            'Our team is verifying your data you will be notified on approval',
                                        duration: const Duration(seconds: 5));
                                  }
                                },
                                child: Text('Pending',
                                    style: poppinsRegular.copyWith(
                                        color: AppColors.pendingColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.fontSizeDefault)),
                              )
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    profileNameImage(context, 120, true),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Phone', style: normalFontStyle),
                        CustomTextField(
                            enabled: false,
                            controller: phoneController,
                            hintText: 'Phone',
                            keyboard: TextInputType.number),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('First Name', style: normalFontStyle),
                        CustomTextField(
                            enabled: true,
                            controller: fNameController,
                            hintText: 'First Name',
                            keyboard: TextInputType.name),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Last Name', style: normalFontStyle),
                        CustomTextField(
                            enabled: true,
                            controller: lNameController,
                            hintText: 'Last Name',
                            keyboard: TextInputType.name),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Email Address', style: normalFontStyle),
                        CustomTextField(
                            enabled: true,
                            controller: emailController,
                            hintText: 'Email Address',
                            keyboard: TextInputType.emailAddress),
                        const SizedBox(height: Dimensions.paddingSizeDefault),
                        Text('Address', style: normalFontStyle),
                        CustomTextField(
                            enabled: true,
                            controller: addressController,
                            hintText: 'Enter your Address',
                            keyboard: TextInputType.streetAddress),
                      ],
                    )),
                    profileButton(context, fNameController.text,
                        lNameController.text,
                        emailController.text,
                        addressController.text)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}