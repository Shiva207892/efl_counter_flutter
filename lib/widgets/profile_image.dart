import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:efl_counter/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/app_colors.dart';
import '../utils/app_pictures.dart';
import '../utils/dimensions.dart';
import 'custom_button.dart';
import 'custom_snack_bar.dart';

Widget profileButton(BuildContext context, String fname, String lname, String email, String address) {
  final userController = Get.find<UserController>();
  return Obx(
        () => CustomButton(
        buttonText: userController.userProfileLocked.isTrue
            ? 'Profile Locked'
            : 'Update Profile',
        onTap: () async {
          userController.userProfileLocked.isTrue
              ? showCustomSnackbar(
              title: 'Profile Locked',
              message:
              'Your information is safe and secured.',
              backColor: Colors.green)
              : await userController.updateUserData(
            fname, lname, email,address
          );
        }),
  );
}

Widget profileNameImage(BuildContext context, double imageSize, bool editable) {
  final userController = Get.find<UserController>();

  return Center(
    child: Column(
      children: [
        Obx(
          () => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(imageSize/2)
            ),
            elevation: 4,
            child: Stack(
              children: [
                Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.2, color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(imageSize / 2),
                  ),
                  child: userController.userProfile.value == null
                      ? userController.userPhoto.value.isNotEmpty
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(imageSize / 2),
                        child: CachedNetworkImage(
                                imageUrl: userController.userPhoto.value,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                          )
                          : Image.asset(AppPictures.profileIcon)
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
                                return BottomSheetWidget();
                              },
                            ),
                            child: const Padding(
                              padding:
                                  EdgeInsets.all(Dimensions.paddingSizeLarge),
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
                      ? AppColors.approvedColor
                      : AppColors.pendingColor,
                  size: 20,
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
                child: userController.userStatus.value == 'Approved'
                    ? Image.asset(AppPictures.approveIcon, width: 20, height: 20)
                    : const Icon(Icons.pending, color: AppColors.pendingColor, size: 20),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  Future<void> getImage(BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      // Handle the selected image
      print('Selected image path: ${image.path}');
      Get.find<UserController>().userProfile.value = File(image.path);
      // You can perform further actions with the selected image here
    }
    // Dismiss the bottom sheet after selecting an image
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Take Photo'),
          onTap: () => getImage(context, ImageSource.camera),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Choose from Gallery'),
          onTap: () => getImage(context, ImageSource.gallery),
        ),
      ],
    );
  }
}
