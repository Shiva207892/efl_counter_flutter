import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/add_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildTotalColumn(
    BuildContext context, AddDataController dataController) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.22,
    child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.25,
        ),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.75), borderRadius: BorderRadius.circular(10)),
              child: Center(
                  child: Obx(
                () => Text(
                    index == 0
                        ? dataController.twoWheelerCounter.value > 0
                            ? dataController.twoWheelerCounter.value.toString()
                            : ''
                        : index == 1
                            ? dataController.threeWheelerCounter.value > 0
                                ? dataController.threeWheelerCounter.value
                                    .toString()
                                : ''
                            : dataController.fourWheelerCounter.value > 0
                                ? dataController.fourWheelerCounter.value
                                    .toString()
                                : '',
                    style: poppinsBold),
              )));
        }),
  );
}
