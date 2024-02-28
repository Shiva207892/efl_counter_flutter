import 'package:efl_counter/controllers/hub_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/user_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/dimensions.dart';
import 'package:efl_counter/widgets/base_gradient.dart';
import '../../controllers/app_controller.dart';

class HubsScreen extends StatefulWidget {
  const HubsScreen({Key? key}) : super(key: key);

  @override
  State<HubsScreen> createState() => _HubsScreenState();
}

class _HubsScreenState extends State<HubsScreen> {
  final UserController userController = Get.find<UserController>();
  final hubsController = Get.find<HubsController>();

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
            Obx(
                  () => ListView.builder(
                itemCount: hubsController.hubsData.length,
                itemBuilder: (context, index) {
                  final hubData = hubsController.hubsData[index];
                  final customers = (hubData as Map<String, dynamic>)['customers'] as List<dynamic>;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ExpansionTile(
                        collapsedBackgroundColor: Colors.white,
                        tilePadding: const EdgeInsets.all(
                          Dimensions.paddingSizeDefault,
                        ),
                        title: Text(
                          hubData['hubName'] ?? '',
                          style: poppinsBold,
                        ),
                        children: customers.map<Widget>((customer) {
                          return ListTile(
                            title: Text(customer ?? ''),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}