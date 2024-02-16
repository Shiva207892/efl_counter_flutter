import 'dart:io';

import 'package:efl_counter/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_colors.dart';
import '../utils/app_pictures.dart';
import '../utils/dimensions.dart';

Widget profileNameImage(BuildContext context, double imageSize, bool editable) {
  final userController = Get.find<UserController>();

  Future<void> _getImage(BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // Handle the selected image
      print('Selected image path: ${image.path}');
      userController.userProfile.value = File(image.path);
      // You can perform further actions with the selected image here
    }
    // Dismiss the bottom sheet after selecting an image
    Navigator.of(context).pop();
  }

  return Center(
    child: Column(
      children: [
        Obx(
              () => Stack(
            children: [
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(imageSize / 2),
                ),
                child: userController.userProfile.value == null
                    ? Padding(
                  padding:
                  const EdgeInsets.all(Dimensions.paddingSizeLarge),
                  child: userController.userPhoto.value.isNotEmpty
                      ? Image.network(userController.userPhoto.value)
                      : Image.asset(AppPictures.profileIcon),
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(imageSize / 2),
                  child: Image.file(
                    userController.userProfile.value!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              editable
                  ? Positioned.fill(
                right: -7,
                top: -7,
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return BottomSheetWidget(
                          onImageSelected: (context, source) {
                            _getImage(context, source);
                          },
                        );
                      },
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(Dimensions.paddingSizeLarge),
                      child: Icon(
                        Icons.edit,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              )
                  : const SizedBox(),
            ],
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Obx(
              () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Icon(
                  Icons.circle,
                  color: userController.userIsOnline.isTrue
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              Text(
                '${userController.userFirstName.value} ${userController.userLastName.value}',
                style: GoogleFonts.inter(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
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
        ),
      ],
    ),
  );
}

class BottomSheetWidget extends StatelessWidget {
  final Function(BuildContext context, ImageSource source) onImageSelected;

  BottomSheetWidget({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.camera),
            title: const Text('Take Photo'),
            onTap: () {
              onImageSelected(context, ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Choose from Gallery'),
            onTap: () {
              onImageSelected(context, ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}