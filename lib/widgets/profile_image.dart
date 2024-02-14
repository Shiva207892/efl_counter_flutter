import 'package:efl_counter/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';
import '../utils/app_pictures.dart';
import '../utils/dimensions.dart';

Widget profileNameImage(double imageSize, bool editable) {
  final userController = Get.find<UserController>();

  return Center(
      child: Column(
        children: [
          Stack(
    children: [
          Container(
              width: imageSize,
              height: imageSize,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(imageSize / 2)),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Image.asset(AppPictures.profileIcon),
              )),
          editable
              ? Positioned.fill(
                  left: -15,
                  bottom: -15,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () => print('change dp'),
                      child: const Padding(
                        padding: EdgeInsets.all(Dimensions.paddingSizeLarge),
                        child: Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ))
              : const SizedBox(),
    ],
  ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${userController.userFirstName.value} ${userController.userLastName.value}',
                style: GoogleFonts.inter(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.fontSizeExtraLarge),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: userController.userStatus.value == 'approved'
                    ? const Icon(
                  Icons.verified_outlined,
                  color: AppColors.approvedColor,
                )
                    : const Icon(Icons.pending, color: AppColors.pendingColor),
              )
            ],
          ),
        ],
      ));
}