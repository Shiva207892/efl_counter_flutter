import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efl_counter/common/date_converter.dart';
import 'package:efl_counter/common/styles.dart';
import 'package:efl_counter/controllers/user_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/dimensions.dart';
import '../widgets/custom_button.dart';
import 'custom_toast.dart';

class ReportSubmitDialog extends StatefulWidget {
  final Map<String, dynamic> reportData;
  const ReportSubmitDialog({Key? key, required this.reportData})
      : super(key: key);

  @override
  State<ReportSubmitDialog> createState() => _ReportSubmitDialogState();
}

class _ReportSubmitDialogState extends State<ReportSubmitDialog> {
  bool isSubmitting = false;
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: 700,
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Submit Report',
                    style: poppinsBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: const SizedBox(child: Icon(Icons.clear)),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Submit By: ',
                      style: TextStyle(color: Colors.blue), // Title color
                    ),
                    TextSpan(
                      text: '${userController.userFirstName}',
                      style: const TextStyle(color: AppColors.primaryColor), // Value color
                    ),
                    const TextSpan(text: '\n'), // Line break
                    const TextSpan(
                      text: 'Submit Date: ',
                      style: TextStyle(color: Colors.blue), // Title color
                    ),
                    TextSpan(
                      text: DateConverter.estimatedDate(DateTime.now()),
                      style: const TextStyle(color: AppColors.primaryColor), // Value color
                    ),
                    const TextSpan(text: '\n'), // Line break
                    const TextSpan(
                      text: 'Report Date: ',
                      style: TextStyle(color: Colors.blue), // Title color
                    ),
                    TextSpan(
                      text: DateConverter.estimatedDate(widget.reportData['reportDate']),
                      style: const TextStyle(color: AppColors.primaryColor), // Value color
                    ),
                    const TextSpan(text: '\n'), // Line break
                    const TextSpan(
                      text: 'Report Hub: ',
                      style: TextStyle(color: Colors.blue), // Title color
                    ),
                    TextSpan(
                      text: '${widget.reportData['reportHub']}',
                      style: const TextStyle(color: AppColors.primaryColor), // Value color
                    ),
                    const TextSpan(text: '\n'), // Line break
                    const TextSpan(
                      text: 'Report Customer: ',
                      style: TextStyle(color: Colors.blue), // Title color
                    ),
                    TextSpan(
                      text: '${widget.reportData['reportCustomer']}',
                      style: const TextStyle(color: AppColors.primaryColor), // Value color
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: Dimensions.paddingSizeExtraLarge,
              ),

              Row(children: [
                Expanded(
                    child: CustomButton(
                        buttonText: 'cancel',
                        onTap: () => Navigator.of(context).pop(false))),
                const SizedBox(width: Dimensions.paddingSizeDefault),
                Expanded(
                    child: isSubmitting
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor))
                        : CustomButton(
                            buttonText: 'Submit',
                            onTap: () {
                              setState(() {
                                isSubmitting = true;
                              });

                              // Add the new document to the collection
                              var reportsCollection = FirebaseFirestore.instance
                                  .collection('DailyReports');

                              reportsCollection
                                  .add(widget.reportData)
                                  .then((value) {
                                Toast.success('Report submitted successfully');
                                setState(() {
                                  isSubmitting = false;
                                });
                                Future.delayed(Duration.zero,
                                    () => Navigator.of(context).pop(true));
                              }).catchError((error) {
                                Toast.error('Report submission failed.');
                                setState(() {
                                  isSubmitting = false;
                                });
                                Future.delayed(Duration.zero,
                                    () => Navigator.of(context).pop(false));
                              });
                            },
                          )),
              ])
            ]),
      ),
    );
  }
}
