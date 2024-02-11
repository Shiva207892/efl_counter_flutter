import 'package:efl_counter_flutter/controllers/app_controller.dart';
import 'package:efl_counter_flutter/utils/app_colors.dart';
import 'package:efl_counter_flutter/views/authentication/login_screen.dart';
import 'package:efl_counter_flutter/views/authentication/otp_screen.dart';
import 'package:efl_counter_flutter/views/dashboard/home_screen.dart';
import 'package:efl_counter_flutter/views/drawer/add_data_screen.dart';
import 'package:efl_counter_flutter/views/drawer/contact_us_screen.dart';
import 'package:efl_counter_flutter/views/drawer/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controllers/add_data_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Set the status bar and navigation bar colors
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryColor,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.primaryColor
  ));

  Get.put(AppController());
  Get.put(AddDataController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: AppColors.primaryColor,
        useMaterial3: true,
      ),
      defaultTransition: Transition.zoom,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/otp', page: () => const OtpScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/add_data', page: () => const AddDataScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/contact_us', page: () => const ContactUsScreen()),
        // GetPage(name: '/terms_conditions', page: () => TermsConditionsPage()),
        // GetPage(name: '/register_success', page: () => RegisterSuccessPage()),
        // GetPage(name: '/bottom_home', page: () => MyBottomNavigationPage()),
        // GetPage(name: '/order_confirm', page: () => OrderConfirmationPage()),
        // GetPage(name: '/orders', page: () => MyOrdersPage()),
        // GetPage(name: '/notifications', page: () => NotificationPage())
      ],
    );
  }
}