import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/shared_prefs.dart';
import '../widgets/custom_snack_bar.dart';

class UserController extends GetxController {
  RxString userId = ''.obs;
  RxBool userIsOnline = false.obs;
  RxBool userProfileLocked = false.obs;
  RxString userPhoto = ''.obs;
  Rx<File?> userProfile = Rx<File?>(null);
  RxString userFirstName = ''.obs;
  RxString userLastName = ''.obs;
  RxString userEmail = ''.obs;
  RxString userPhone = ''.obs;
  RxString userStatus = ''.obs;
  RxString userAddress = ''.obs;

  var usersCollection = FirebaseFirestore.instance.collection('Users');
  late StreamSubscription<DocumentSnapshot> _userSubscription;

  @override
  void onInit() {
    super.onInit();
    getUserData();
    updateUserOnline(true);
    updateUserFcm();
  }

  @override
  void onClose() {
    // Unsubscribe from real-time updates when the controller is closed
    _userSubscription.cancel();
    super.onClose();
  }

  Future<void> getUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        userId.value = user.uid;
        DocumentReference userRef = usersCollection.doc(userId.value);

        // Listen for real-time updates and assign the subscription to _userSubscription
        _userSubscription = userRef.snapshots().listen((DocumentSnapshot userSnapshot) async {
          if (userSnapshot.exists) {
            var userData = userSnapshot.data() as Map<String, dynamic>;
            // Update user data based on userSnapshot
            userPhone.value = userData['phone'] ?? '';
            userIsOnline.value = userData['isOnline'] ?? true;
            userProfileLocked.value = userData['profileLock'] ?? false;
            userPhoto.value = userData['photo'] ?? '';
            userStatus.value = userData['status'] ?? '';
            userFirstName.value = userData['fname'] ?? '';
            userLastName.value = userData['lname'] ?? '';
            userEmail.value = userData['email'] ?? '';
            userAddress.value = userData['address'] ?? '';
            if (userData['status'] == 'Pending') {
              if (Get.currentRoute != '/profile') {
                Get.offAllNamed(
                  '/profile',
                  parameters: {
                    'phone': userPhone.value,
                    'photo': userPhoto.value,
                    'status': userStatus.value,
                    'firstName': userFirstName.value,
                    'lastName': userLastName.value,
                    'email': userEmail.value,
                    'address': userAddress.value,
                  },
                );
              }
            } else {
              if (Get.currentRoute != '/home') {
                Get.offAllNamed('/home');
              }
            }
          } else {
            if (kDebugMode) {
              print('User with ID $userId does not exist.');
            }
            showCustomSnackbar(title: 'Error', message: 'Account with this phone number does not exist');
            FirebaseAuth.instance.signOut();
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
          'uid': uid,
          'phone': user.phoneNumber,
          'status': 'Pending',
          'isOnline': true,
          'profileLock': false,
          'photo': '',
          'fname': 'Guest',
          'lname': 'User',
          'email': 'guest@gmail.com',
          'address': '',
          'hubs': [],
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

  Future<void> updateUserData(String firstName, String lastName, String email, String address) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the current user's UID
        String uid = user.uid;

        // Reference the user document by their UID
        DocumentReference userRef = usersCollection.doc(uid);

        String? photoPath = userPhoto.value;

        // If userProfile is not null, upload the file to Firebase Storage
        if (userProfile.value != null) {
          // Reference to the Firebase Storage location where the file will be stored
          Reference storageRef = FirebaseStorage.instance.ref().child('UserProfiles').child(uid);

          // Upload the file to Firebase Storage
          await storageRef.putFile(userProfile.value!);

          // Get the download URL of the uploaded file
          String downloadURL = await storageRef.getDownloadURL();

          // Update the photoPath with the download URL
          photoPath = downloadURL;
        }

        // Update the data for the user document
        await userRef.update({
          'fname': firstName,
          'lname': lastName,
          'email': email,
          'address': address,
          'photo': photoPath
        });

        // Update local user data after successful update
        userFirstName.value = firstName;
        userLastName.value = lastName;
        userEmail.value = email;
        userAddress.value = address;

        if (kDebugMode) {
          print("User data updated");
          showCustomSnackbar(
              title: 'Success',
              message: 'Profile updated successfully',
              duration: const Duration(seconds: 2), backColor: Colors.green);
        }
      } else {
        if (kDebugMode) {
          print("User not signed in.");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to update user data: $error");
      }
    }
  }

  Future<void> updateUserOnline(bool isOnline) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the current user's UID
        String uid = user.uid;

        // Reference the user document by their UID
        DocumentReference userRef = usersCollection.doc(uid);

        // Update the data for the user document
        await userRef.update({
          'isOnline': isOnline,
          'lastSeen': DateTime.now()
        });

        // Update local user data after successful update
        userIsOnline.value = isOnline;

        if (kDebugMode) {
          print("User data updated");
        }
      } else {
        if (kDebugMode) {
          print("User not signed in.");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to update user data: $error");
      }
    }
  }

  Future<void> updateUserFcm() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Get the current user's UID
        String uid = user.uid;

        // Reference the user document by their UID
        DocumentReference userRef = usersCollection.doc(uid);

        final fcmToken = await FirebaseMessaging.instance.getToken();

        // Update the data for the user document
        await userRef.update({
          'fcm': fcmToken,
        });
        if (kDebugMode) {
          print("User fcm token updated");
        }
      } else {
        if (kDebugMode) {
          print("User not signed in.");
        }
      }
    } catch (error) {
      if (kDebugMode) {
        print("Failed to update user data: $error");
      }
    }
  }

  Future<void> logoutUser() async {
    try {
      await updateUserOnline(false);
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