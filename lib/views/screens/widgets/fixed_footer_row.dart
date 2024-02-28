import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/add_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildFooterRow(BuildContext context) {
  final dataController = Get.find<AddDataController>();
  return Row(
    children: List.generate(
      4,
          (index) => Expanded(
        child: Container(
          alignment: Alignment.center,
          color: Colors.white.withOpacity(0.75),
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Obx(
            () => Text(
              index == 0
                  ? dataController.chargingCounter.value > 0 ? 'Total' : 'Total'
                  : index == 1
                  ? dataController.parkingCounter.value > 0 ? dataController.parkingCounter.value.toString() : ''
                  : index == 2
                  ? dataController.chargingCounter.value > 0 ? dataController.chargingCounter.value.toString() : ''
                  : dataController.totalCounter.value > 0 ? (dataController.totalCounter.value).toString() : '',
              style: poppinsBold,
            ),
          ),
        ),
      ),
    ),
  );
}
