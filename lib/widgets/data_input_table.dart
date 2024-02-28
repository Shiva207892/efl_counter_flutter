import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/add_data_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/screens/widgets/build_counter_column.dart';
import '../views/screens/widgets/build_vehicle_column.dart';
import '../views/screens/widgets/custom_text_field.dart';

class TextInputTable extends StatefulWidget {
  const TextInputTable({Key? key})
      : super(key: key);

  @override
  TextInputTableState createState() => TextInputTableState();
}

class TextInputTableState extends State<TextInputTable> {
  final dataController = Get.find<AddDataController>();
  int parking = 0;
  int charging = 0;
  int totalVehicles = 0;
  int twoWheelerTotal = 0;
  int threeWheelerTotal = 0;
  int fourWheelerTotal = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.270,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildVehicleColumn(context),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child:
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // Set physics to prevent scrolling
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 1.38,
                ),
                itemCount: dataController.inputControllers.length,
                itemBuilder: (BuildContext context, int index) {
                  return customTextField(context, index, dataController);
                },
              ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          buildTotalColumn(context, dataController),
        ],
      ),
    );
  }
}
