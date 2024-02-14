import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../common/shared_prefs.dart';

class UserController extends GetxController {
  RxBool isLoggedIn = false.obs;
  RxBool isRegistered = false.obs;
  RxString userId = 'uid'.obs;
  RxString userFirstName = 'Guest'.obs;
  RxString userLastName = 'User'.obs;
  RxString userEmail = 'guest@gmail.com'.obs;
  RxString userPhone = 'XXXXXXXXXX'.obs;
  RxString userStatus = 'pending'.obs;

  var usersCollection = FirebaseFirestore.instance.collection('Users');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Get the current user's UID
        userId.value = user.uid;

        // Reference the user document by their UID
        DocumentReference userRef = usersCollection.doc(userId.value);

        // Subscribe to real-time updates on the document
        userRef.snapshots().listen((userSnapshot) {
          if (userSnapshot.exists) {
            if (kDebugMode) {
              print('User data: ${userSnapshot.data()}');
            }
            var userData = userSnapshot.data() as Map<String, dynamic>;
            userFirstName.value = userData['fname'];
            userLastName.value = userData['lname'];
            userEmail.value = userData['email'];
            userPhone.value = userData['phone'];
            userStatus.value = userData['status'];
            isLoggedIn.value = true;
            isRegistered.value = true;
            if (userData['status'] == 'pending') {
              Future.delayed(Duration.zero, () => Get.offAllNamed('/profile'));
            } else {
              Future.delayed(Duration.zero, () => Get.offAllNamed('/home'));
            }
          } else {
            if (kDebugMode) {
              print('User with ID $userId does not exist.');
            }
          }

        });
      } else {
        if (kDebugMode) {
          print("User not signed in.");
          Future.delayed(Duration.zero, () => Get.toNamed('/login'));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to get user: $e');
        Future.delayed(Duration.zero, () => Get.toNamed('/login'));
      }
    }
  }

  Future<void> addUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the current user's UID
        String uid = user.uid;

        // Reference the user document by their UID
        DocumentReference userRef = usersCollection.doc(uid);

        // Set the data for the user document
        await userRef.set({
          'fname': 'Guest',
          'lname': 'User',
          'email': 'guest@gmail.com',
          'phone': user.phoneNumber,
          'status': 'pending'
        });

        if (kDebugMode) {
          print("User added");
        }
      } else {
        if (kDebugMode) {
          print("User not signed in.");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to add user: $error");
      }
    }
  }

  Future<void> logoutUser() async {
    try {
      await SharedPrefs.clearPreferences();
      await FirebaseAuth.instance.signOut();
      if (kDebugMode) {
        print("User signed out");
        Get.offAllNamed('/login');
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to sign out: $error");
      }
    }
  }
}
