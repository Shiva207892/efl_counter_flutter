import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efl_counter/common/custom_toast.dart';
import 'package:efl_counter/common/date_converter.dart';
import 'package:efl_counter/controllers/app_controller.dart';
import 'package:efl_counter/controllers/hub_controller.dart';
import 'package:efl_counter/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDataController extends GetxController {
  RxInt parkingCounter = 0.obs;
  RxInt chargingCounter = 0.obs;
  RxInt totalCounter = 0.obs;

  RxInt twoWheelerCounter = 0.obs;
  RxInt threeWheelerCounter = 0.obs;
  RxInt fourWheelerCounter = 0.obs;

  final twoParkingController = TextEditingController();
  final twoChargingController = TextEditingController();
  final threeParkingController = TextEditingController();
  final threeChargingController = TextEditingController();
  final fourParkingController = TextEditingController();
  final fourChargingController = TextEditingController();

  List<TextEditingController> inputControllers = [];

  List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  RxList<String> indianStatesList = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli and Daman and Diu",
    "Lakshadweep",
    "Delhi",
    "Puducherry",
  ].obs;

  var reportsCollection = FirebaseFirestore.instance.collection('DailyReports');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    inputControllers = [
      twoParkingController,
      twoChargingController,
      threeParkingController,
      threeChargingController,
      fourParkingController,
      fourChargingController
    ];
  }

  @override
  void onClose() {
    // TODO: implement onClose
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void clearCounters() {
    chargingCounter.value = 0;
    parkingCounter.value = 0;
    totalCounter.value = 0;
    twoWheelerCounter.value = 0;
    threeWheelerCounter.value = 0;
    fourWheelerCounter.value = 0;
  }

  void clearControllers() {
    twoParkingController.clear();
    twoChargingController.clear();
    threeParkingController.clear();
    threeChargingController.clear();
    fourParkingController.clear();
    fourChargingController.clear();
  }

  void checkAndUpdateData() {
    clearCounters();

    //calculate total Parkings
    if (twoParkingController.text.isNotEmpty) {
      parkingCounter.value += int.parse(twoParkingController.text);
      twoWheelerCounter.value += int.parse(twoParkingController.text);
    }
    if (threeParkingController.text.isNotEmpty) {
      parkingCounter.value += int.parse(threeParkingController.text);
      threeWheelerCounter.value += int.parse(threeParkingController.text);
    }
    if (fourParkingController.text.isNotEmpty) {
      parkingCounter.value += int.parse(fourParkingController.text);
      fourWheelerCounter.value += int.parse(fourParkingController.text);
    }

    //calculate total Chargings
    if (twoChargingController.text.isNotEmpty) {
      chargingCounter.value += int.parse(twoChargingController.text);
      twoWheelerCounter.value += int.parse(twoChargingController.text);
    }
    if (threeChargingController.text.isNotEmpty) {
      chargingCounter.value += int.parse(threeChargingController.text);
      threeWheelerCounter.value += int.parse(threeChargingController.text);
    }
    if (fourChargingController.text.isNotEmpty) {
      chargingCounter.value += int.parse(fourChargingController.text);
      fourWheelerCounter.value += int.parse(fourChargingController.text);
    }

    //calculate total Parkings and Chargings
    totalCounter.value = parkingCounter.value + chargingCounter.value;

    print(twoParkingController.text);
    // Future.delayed(
    //     Duration.zero, () => Get.toNamed('/report_success'));
  }

  // Function to compare only the date components of DateTime objects
  bool areDatesEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Future<bool> fetchReportStatus(String customerId) async {
    // Get the required data
    final hubsController = Get.find<HubsController>();
    final userId = Get.find<UserController>().userId.value;
    final hubId = hubsController.selectedHub.value;
    final reportDate = Get.find<AppController>().currentSelectedDate.value;

    try {
      // Query to find existing reports data based on user, customer, hub, and date
      QuerySnapshot querySnapshot = await reportsCollection
          .where('reportUser', isEqualTo: userId)
          .where('reportHub', isEqualTo: hubId)
          .where('reportCustomer', isEqualTo: customerId)
          .get();

      // Iterate over the documents to check if any match the reportDate
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Get the timestamp from the document data
        Timestamp timestamp = doc['reportDate'];

        // Convert the timestamp to DateTime
        DateTime documentDate = timestamp.toDate();

        // Compare only the date components of the two dates
        if (areDatesEqual(documentDate, reportDate)) {
          // Found existing report for the provided date
          print('Found existing report for the provided date.');
          return true;
        }
      }

      // No report found for the provided date
      print('No existing report found for the provided date.');
      return false;
    } catch (e) {
      // Handle any errors that occur during the query
      print('Error checking report existence: $e');
      return false; // Assume report does not exist if an error occurs
    }
  }

  Future<Map<String, Object>?> submitReport(BuildContext context) async {
    final appController = Get.find<AppController>();
    final hubsController = Get.find<HubsController>();

    DateTime currentDate = DateTime.now();
    DateTime selectedDate = appController.currentSelectedDate.value;

// Calculate the difference in days between selected date and current date
    int daysDifference = currentDate.difference(selectedDate).inDays;

// Check if the selected date is within the allowed range (today and the past 6 days)
    if (daysDifference >= 0 && daysDifference < 7) {
      // Allow submission
      // Add your submission logic here
      Toast.success(
          'Submitting report for selected date: ${DateConverter.estimatedDate(selectedDate)}');
    } else {
      // Display error toast if selected date is not within the allowed range
      print('Selected date is not within the allowed range.');
      // Show error message using a toast or dialog
      // For demonstration purposes, printing a message here
      Toast.error(
          'Cannot submit reports for dates other than today and the past 6 days.');
      return null;
    }

    if (hubsController.selectedHub.value == '') {
      Toast.error('Please select Hub from top left drop down');
      return null;
    }

    if (hubsController.selectedCustomer.value == '') {
      Toast.error('Please select Customer from top right drop down');
      return null;
    }

    if (twoParkingController.text.isEmpty) {
      Toast.error('Enter two wheeler parkings please');
      return null;
    }
    if (twoChargingController.text.isEmpty) {
      Toast.error('Enter two wheeler chargings please');
      return null;
    }
    if (threeParkingController.text.isEmpty) {
      Toast.error('Enter three wheeler parkings please');
      return null;
    }
    if (threeChargingController.text.isEmpty) {
      Toast.error('Enter three wheeler chargings please');
      return null;
    }
    if (fourParkingController.text.isEmpty) {
      Toast.error('Enter four wheeler parkings please');
      return null;
    }
    if (fourChargingController.text.isEmpty) {
      Toast.error('Enter four wheeler chargings please');
      return null;
    }

    final userController = Get.find<UserController>();

    var reportData = {
      'reportDate': appController.currentSelectedDate.value,
      'submitTime': DateTime.now(),
      'reportUser': userController.userId.value,
      'reportHub': hubsController.selectedHub.value,
      'reportCustomer': hubsController.selectedCustomer.value,
      'reportData': {
        'p2': twoParkingController.text.toString().trim(),
        'c2': twoChargingController.text.toString().trim(),
        'p3': threeParkingController.text.toString().trim(),
        'c3': threeChargingController.text.toString().trim(),
        'p4': fourParkingController.text.toString().trim(),
        'c4': fourChargingController.text.toString().trim(),
      }
    };

    print('Date is: ${appController.currentSelectedDate.value}');
    print('UserId is: ${userController.userId.value}');
    print('Hub is: ${hubsController.selectedHub.value}');
    print('Customer is: ${hubsController.selectedCustomer.value}');
    print('Report data is: $reportData');

    bool isSubmitted =
        await fetchReportStatus(hubsController.selectedCustomer.value);
    if (isSubmitted) {
      Toast.success('Report already submitted');
      return null;
    }

    return reportData;
  }
}
