import 'package:efl_counter/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/app_controller.dart';
import '../../widgets/base_gradient.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

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
            child: baseGradientContainer(context,
                const SingleChildScrollView(child: Center(child: Text('Reports'))))),
      ),
    );
  }
}
