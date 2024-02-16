import 'package:efl_counter/controllers/user_controller.dart';
import 'package:efl_counter/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/base_gradient.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/profile_image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController fNameController;
  late TextEditingController lNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController addressController;

  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> args = Get.parameters;
    final String phone = args['phone'] ?? '';
    final String status = args['status'] ?? '';
    final String firstName = args['firstName'] ?? '';
    final String lastName = args['lastName'] ?? '';
    final String email = args['email'] ?? '';
    final String address = args['address'] ?? '';

    fNameController = TextEditingController(text: firstName);
    lNameController = TextEditingController(text: lastName);
    phoneController = TextEditingController(text: phone);
    emailController = TextEditingController(text: email);
    addressController = TextEditingController(text: address);
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
    var normalFontStyle = GoogleFonts.inter(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: Dimensions.fontSizeDefault);

    return Scaffold(
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  userController.userStatus.value == 'pending'
                          ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => userController.logoutUser(),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeDefault),
                              child: Text('Logout',
                                  style: GoogleFonts.inter(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                      Dimensions.fontSizeDefault)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if(userController.userStatus.value == 'pending') {
                                showCustomSnackbar(title: 'Confirmation Pending:', message: 'Our team is verifying your data you will be notified on approval', duration: const Duration(seconds: 5));
                              }
                            },
                            child: Text('Pending',
                                style: GoogleFonts.inter(
                                    color: AppColors.pendingColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                    Dimensions.fontSizeDefault)),
                          )
                        ],
                      )
                          : const SizedBox(),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  profileNameImage(context, 120, true),
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
                  const SizedBox(height: 40),
                  CustomButton(
                      buttonText: 'Update Profile',
                      onTap: () async {
                        print('update profile');
                        await userController.updateUserData(
                            fNameController.text,
                            lNameController.text,
                            emailController.text,
                            addressController.text);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}