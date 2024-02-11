import 'package:get/get.dart';

class AppController extends GetxController {
  RxInt currentPageIndex = 0.obs;
  Rx<DateTime> currentSelectedDate = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void setCurrentPageIndex(int index) {
    currentPageIndex.value = index;
  }

  void incrementDate() {
    // Get the current date from the Rx<DateTime> variable
    DateTime currentDate = currentSelectedDate.value;

    // Increment the date by 1 day
    DateTime newDate = currentDate.add(const Duration(days: 1));

    // Update the Rx<DateTime> variable with the new date
    currentSelectedDate.value = newDate;
  }

  void decrementDate() {
    // Get the current date from the Rx<DateTime> variable
    DateTime currentDate = currentSelectedDate.value;

    // Decrement the date by 1 day
    DateTime newDate = currentDate.subtract(const Duration(days: 1));

    // Update the Rx<DateTime> variable with the new date
    currentSelectedDate.value = newDate;
  }

  void setCurrentSelectedDate(DateTime selectedDate) {
    currentSelectedDate.value = selectedDate;
  }
}