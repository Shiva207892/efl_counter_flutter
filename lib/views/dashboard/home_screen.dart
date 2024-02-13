import 'package:efl_counter/controllers/app_controller.dart';
import 'package:efl_counter/views/drawer/add_data_screen.dart';
import 'package:efl_counter/views/drawer/contact_us_screen.dart';
import 'package:efl_counter/views/drawer/profile_screen.dart';
import 'package:efl_counter/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();

    return Obx(
      () => Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: appController.currentPageIndex.value == 0
              ? customAppBar(context)
              : null,
          drawer: const CustomDrawer(),
          body: Obx(() => getHomePage(appController.currentPageIndex.value))),
    );
  }

  getHomePage(int value) {
    switch (value) {
      case 0:
        return const AddDataScreen();
      case 1:
        return const ProfileScreen();
      case 2:
        return const ContactUsScreen();
      default:
        return const AddDataScreen();
    }
  }
}