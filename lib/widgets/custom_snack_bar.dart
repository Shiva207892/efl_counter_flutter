import 'package:efl_counter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

SnackbarController showCustomSnackbar({String? title, Color? titleColor, String? message, Color? msgColor, Color? backColor, SnackPosition? position, Duration? duration}) {
  var titleStyle = GoogleFonts.poppins(fontWeight: FontWeight.bold, color: titleColor ?? Colors.white, fontSize: Dimensions.fontSizeLarge);
  var messageStyle = GoogleFonts.poppins(fontWeight: FontWeight.w300, color: msgColor ?? Colors.white, fontSize: Dimensions.fontSizeDefault);
  return Get.snackbar(title ?? '', message ?? '', backgroundColor: backColor ?? Colors.red,
   titleText: Text(title ?? '', style: titleStyle),
    messageText: Text(message ?? '', style: messageStyle),
    snackPosition: position ?? SnackPosition.BOTTOM,
    duration: duration ?? const Duration(seconds: 1)
  );
}