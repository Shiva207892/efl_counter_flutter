import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:efl_counter/common/custom_toast.dart';
import 'package:efl_counter/controllers/hub_controller.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxInt currentPageIndex = 0.obs;
  Rx<DateTime> currentSelectedDate = DateTime.now().obs;
  late StreamSubscription<ConnectivityResult> subscription;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Initialize the subscription to listen for changes in connectivity
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // This callback function will be called whenever the connectivity status changes
      // You can handle the connectivity change here
      handleConnectivityChange(result);
    });
  }

// Be sure to cancel subscription after you are done
  @override
  void onClose() {
    // Cancel the subscription to prevent memory leaks
    subscription.cancel();
    super.onClose();
  }

  void handleConnectivityChange(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        // No internet connection
        // Handle the scenario when there is no internet connection
        Toast.error('Network Error');
        break;
      case ConnectivityResult.wifi:
        // Connected to WiFi network
        // Handle the scenario when connected to a WiFi network
        Toast.success('Network Connected');

        break;
      case ConnectivityResult.mobile:
        // Connected to mobile network
        // Handle the scenario when connected to a mobile network
        Toast.success('Network Connected');
        break;
      default:
        break;
    }
  }

  void setCurrentPageIndex(int index) {
    currentPageIndex.value = index;
  }

  void incrementDate() {
    // Get the current date from the Rx<DateTime> variable
    DateTime currentDate = currentSelectedDate.value;

    // Get today's date
    DateTime today = DateTime.now();

    // Check if the current date is not today
    if (!isSameDay(currentDate, today)) {
      // Increment the date by 1 day
      DateTime newDate = currentDate.add(const Duration(days: 1));

      setCurrentSelectedDate(newDate);
    } else {
      Toast.error('Can not select future dates');
    }
  }

  // Function to check if two dates are the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void decrementDate() {
    // Get the current date from the Rx<DateTime> variable
    DateTime currentDate = currentSelectedDate.value;

    // Decrement the date by 1 day
    DateTime newDate = currentDate.subtract(const Duration(days: 1));

    setCurrentSelectedDate(newDate);
  }

  void setCurrentSelectedDate(DateTime selectedDate) {
    final DateTime today = DateTime.now();
    final Duration difference = today.difference(selectedDate).abs();

    if (difference.inDays <= 7) {
      currentSelectedDate.value = selectedDate;
      final hubsController = Get.find<HubsController>();
      hubsController.updateSelectedHub(hubsController.hubIds[0]);
    } else {
      Toast.error("Can not select more than 7 days ago.");
    }
  }
}