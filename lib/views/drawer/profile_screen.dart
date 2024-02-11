import 'package:efl_counter_flutter/utils/app_pictures.dart';
import 'package:efl_counter_flutter/utils/dimensions.dart';
import 'package:efl_counter_flutter/widgets/base_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<AppController>().setCurrentPageIndex(0);
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text('My Profile')),
                        Center(child: Image.asset(AppPictures.profileIcon)),
                        Text('First Name'),
                        Text('Last Name'),
                        Text('Email Address'),
                        Text('Phone Number'),
                        Text('State'),
                        Text('City'),
                        CustomButton(
                            buttonText: 'Update Profile',
                            onTap: () {
                              print('update profile');
                              Get.toNamed('/home');
                            })
                      ],
                    ),
                  ),
                ))),
      ),
    );
  }
}
