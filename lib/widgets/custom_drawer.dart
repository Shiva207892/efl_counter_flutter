import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/app_controller.dart';
import 'package:efl_counter/controllers/user_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.white, width: 2)
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 40,
                        backgroundImage: NetworkImage(userController.userPhoto.value), // Replace with actual user image URL
                      ),
                    ),
                    Positioned(
                        top: 5,
                        left: 5,
                        child: Obx(() => CircleAvatar(radius: 7, backgroundColor: userController.userIsOnline.isTrue ? Colors.green : Colors.yellow,)))
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall,),
                Text(
                  '${userController.userFirstName.value} ${userController.userLastName.value}', // Replace with actual user name
                  style: poppinsBold.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Home', style: poppinsBold.copyWith(color: AppColors.primaryColor),),
            onTap: () {
              Get.find<AppController>().setCurrentPageIndex(0);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: Text('Profile', style: poppinsBold.copyWith(color: AppColors.primaryColor),),
            onTap: () {
              Get.find<AppController>().setCurrentPageIndex(1);
              Navigator.of(context).pop();
            },
          ),

          // ListTile(
          //   title: Text('Your Hubs', style: poppinsBold.copyWith(color: AppColors.primaryColor),),
          //   onTap: () {
          //     Get.find<AppController>().setCurrentPageIndex(2);
          //     Navigator.of(context).pop();
          //   },
          // ),
          // ListTile(
          //   title: Text('Your Reports', style: poppinsBold.copyWith(color: AppColors.primaryColor),),
          //   onTap: () {
          //     Get.find<AppController>().setCurrentPageIndex(3);
          //     Navigator.of(context).pop();
          //   },
          // ),
          ListTile(
            title: Text('Contact Us', style: poppinsBold.copyWith(color: AppColors.primaryColor),),
            onTap: () {
              Get.find<AppController>().setCurrentPageIndex(2);
              Navigator.of(context).pop();
            },
          ),

          ListTile(
            title: Text('Logout', style: poppinsBold.copyWith(color: AppColors.primaryColor),),
            onTap: () => userController.logoutUser(),
          ),
          // Add more list tiles for additional items in the drawer
        ],
      ),
    );
  }
}