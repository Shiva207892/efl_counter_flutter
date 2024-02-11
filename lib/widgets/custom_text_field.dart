import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/dimensions.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode focusNode;
  final String hintText;
  final String? prefixImage;
  final String? suffixImage;

  const CustomTextField({Key? key, required this.focusNode, required this.hintText, this.prefixImage, this.suffixImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeLarge),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: 50,
          color: Colors.white,
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
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: hintText,
                      hintStyle: GoogleFonts.inter(
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
      ),
    );
  }
}