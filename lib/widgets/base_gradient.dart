import 'package:efl_counter_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';

Container baseGradientContainer(BuildContext context, Widget child) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.secondaryColor,
          AppColors.bottomGradientColor,
        ],
      ),
    ),
    child: child,
  );
}