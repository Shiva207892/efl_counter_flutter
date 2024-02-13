import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_pictures.dart';
import '../utils/dimensions.dart';

Widget profileImage(double imageSize, bool editable) {
  return Center(
      child: Stack(
        children: [
          Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(
                      imageSize/2)),
              child: Padding(
                padding: const EdgeInsets.all(
                    Dimensions.paddingSizeLarge),
                child: Image.asset(AppPictures.profileIcon),
              )),
          editable ? Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () => print('change dp'),
                  child: const Padding(
                    padding: EdgeInsets.all(
                        Dimensions.paddingSizeDefault),
                    child: Icon(
                      Icons.camera_alt,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              )) : const SizedBox()
        ],
      ));
}