import 'package:flutter/material.dart';
import '../common/styles.dart';
import '../utils/dimensions.dart';

class CustomTextField extends StatelessWidget {
  final bool? enabled;
  final TextEditingController? controller;
  final String hintText;
  final String? prefixImage;
  final String? suffixImage;
  final Color? fillColor;
  final TextInputType? keyboard;
  final int? maxLength;

  const CustomTextField({Key? key, this.enabled, this.controller, required this.hintText, this.prefixImage, this.suffixImage, this.fillColor, this.keyboard, this.maxLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: 50,
        color: fillColor ?? const Color(0xFFEDEEF1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge),
          child: Row(
            children: [
              prefixImage != null ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  prefixImage!, // Replace 'your_image.png' with your asset image path
                  width: 24, // Adjust width as needed
                  height: 24, // Adjust height as needed
                ),
              ) : const SizedBox(),
              Expanded(
                child: TextField(
                  enabled: enabled ?? false,
                  controller: controller,
                  autofocus: false,
                  keyboardType: keyboard ?? TextInputType.text,
                  maxLength: maxLength ?? 1000,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: fillColor ?? const Color(0xFFEDEEF1),
                    hintText: hintText,
                    counterText: '',
                    hintStyle: poppinsRegular.copyWith(
                      color: Colors.grey,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              suffixImage != null ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  suffixImage!, // Replace 'your_image.png' with your asset image path
                  width: 24, // Adjust width as needed
                  height: 24, // Adjust height as needed
                ),
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}