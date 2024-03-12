import 'package:efl_counter/controllers/add_data_controller.dart';
import 'package:flutter/material.dart';
import '../../../common/styles.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/dimensions.dart';

Widget customTextField(BuildContext context, int index, AddDataController dataController) {
  return TextFormField(
    controller: dataController.inputControllers[index],
    focusNode: dataController.focusNodes[index],
    keyboardType: TextInputType.number,
    style: poppinsBold.copyWith(fontSize: Dimensions.fontSizeLargest, color: AppColors.primaryColor),
    maxLength: 4,
    maxLines: null,
    expands: true,
    textAlign: TextAlign.center,
    onChanged: (value) {
      dataController.checkAndUpdateData();
      if (value.length == 4 && index < dataController.focusNodes.length-1) {
        FocusScope.of(context).requestFocus(dataController.focusNodes[index+1]);
      }
    },
    decoration: InputDecoration(
      fillColor: Colors.white.withOpacity(0.95),
      filled: true,
      counterText: '',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
            color: Colors.blueGrey, width: 5.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
        const BorderSide(color: AppColors.primaryColor, width: 5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide:
         BorderSide(color: dataController.inputControllers[index].text.isEmpty ? Colors.grey : Colors.green, width: 5.0),
      ),
    ),
  );
}