import 'package:efl_counter_flutter/controllers/app_controller.dart';
import 'package:efl_counter_flutter/utils/app_colors.dart';
import 'package:efl_counter_flutter/utils/app_pictures.dart';
import 'package:efl_counter_flutter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), // Initial date
    firstDate: DateTime(2020), // First selectable date
    lastDate: DateTime(2100), // Last selectable date
    // Optional: You can customize the date picker further using additional parameters
    // For example: initialDatePickerMode, selectableDayPredicate, etc.
  );

  if (picked != null) {
    // If a date is selected, do something with it (e.g., update UI, store it, etc.)
    print('Selected date: $picked');
    Get.find<AppController>().setCurrentSelectedDate(picked);
  }
}

AppBar customAppBar(BuildContext context) {
  final appController = Get.find<AppController>();
  return AppBar(
    backgroundColor: AppColors.primaryColor,
    iconTheme: const IconThemeData(
        color: Colors.white), // Change the icon color to white
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => appController.decrementDate(),
          child: Text(
            '  <  ',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.fontSizeLargest,
                color: Colors.white),
          ),
        ),
        FittedBox(
          child: Text(
              DateFormat('EEEE, dd MMMM')
                  .format(appController.currentSelectedDate.value),
              style: GoogleFonts.inter(
                  fontSize: Dimensions.fontSizeLarge, color: Colors.white)),
        ),
        InkWell(
          onTap: () => appController.incrementDate(),
          child: Text(
            '  >  ',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.bold,
                fontSize: Dimensions.fontSizeLargest,
                color: Colors.white),
          ),
        ),
      ],
    ),
    actions: [
      InkWell(
          onTap: () {
            _selectDate(context); // Call function to show date picker
          },
          child: Image.asset(
            AppPictures.calendarIcon,
            color: Colors.white,
            width: 30,
            height: 30,
          )),
      const SizedBox(
        width: Dimensions.paddingSizeLargest,
      )
    ],
  );
}