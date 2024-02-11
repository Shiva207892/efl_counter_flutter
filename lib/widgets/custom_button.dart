import 'package:efl_counter_flutter/utils/app_colors.dart';
import 'package:efl_counter_flutter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final double? buttonHeight;
  final Color? buttonColor;
  final String buttonText;
  final Color? buttonTextColor;
  final double? buttonTextSize;
  final void Function() onTap;
  const CustomButton(
      {super.key,
      this.buttonColor,
      this.buttonHeight,
      required this.buttonText,
      this.buttonTextColor, this.buttonTextSize, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: buttonHeight ?? 50,
        decoration: BoxDecoration(
            color: buttonColor ?? AppColors.primaryColor,
            borderRadius: BorderRadius.circular(50)),
        child: Center(
          child: Text(buttonText,
              style: GoogleFonts.inter(
                color: buttonTextColor ?? Colors.white,
                fontSize: buttonTextSize ?? Dimensions.fontSizeExtraLarge
              )),
        ),
      ),
    );
  }
}