import 'package:efl_counter/configs/firebase_options.dart';
import 'package:efl_counter/controllers/app_controller.dart';
import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/views/authentication/login_screen.dart';
import 'package:efl_counter/views/authentication/otp_screen.dart';
import 'package:efl_counter/views/authentication/splash_screen.dart';
import 'package:efl_counter/views/dashboard/home_screen.dart';
import 'package:efl_counter/views/drawer/add_data_screen.dart';
import 'package:efl_counter/views/drawer/contact_us_screen.dart';
import 'package:efl_counter/views/drawer/privacy_policy_screen.dart';
import 'package:efl_counter/views/drawer/profile_screen.dart';
import 'package:efl_counter/views/drawer/report_success_screen.dart';
import 'package:efl_counter/views/drawer/terms_conditions_screen.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controllers/add_data_controller.dart';
import 'controllers/user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    print('firebase has been initialized');
  }

  await FirebaseAppCheck.instance.activate(
    // You can also use a `ReCaptchaEnterpriseProvider` provider instance as an
    // argument for `webProvider`
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    // Default provider for Android is the Play Integrity provider. You can use the "AndroidProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Safety Net provider
    // 3. Play Integrity provider
    androidProvider:
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    // Default provider for iOS/macOS is the Device Check provider. You can use the "AppleProvider" enum to choose
    // your preferred provider. Choose from:
    // 1. Debug provider
    // 2. Device Check provider
    // 3. App Attest provider
    // 4. App Attest provider with fallback to Device Check provider (App Attest provider is only available on iOS 14.0+, macOS 14.0+)
    appleProvider: kDebugMode ? AppleProvider.debug : AppleProvider.deviceCheck,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Set the status bar and navigation bar colors
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primaryColor));

  Get.put(UserController());
  Get.put(AppController());
  Get.put(AddDataController());

  // Adding WidgetsBindingObserver
  WidgetsBinding.instance.addObserver(AppLifecycleObserver());

  runApp(const MyApp());
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    final userController = Get.find<UserController>();

    // Handle app lifecycle state changes here
    switch (state) {
      case AppLifecycleState.resumed:
      // App is resumed
      print('app resumed');
        await userController.updateUserOnline(true);
        break;
      case AppLifecycleState.inactive:
      // App is inactive
      print('app inactive');
        await userController.updateUserOnline(false);
        break;
      case AppLifecycleState.paused:
      // App is paused
      print('app paused');
        await userController.updateUserOnline(false);
        break;
      case AppLifecycleState.detached:
      // App is detached
      print('app terminated');
        await userController.updateUserOnline(false);
        break;
      case AppLifecycleState.hidden:
        print('app hidden');
        await userController.updateUserOnline(false);
        break;
    }
  }
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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/otp', page: () => const OtpScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/add_data', page: () => const AddDataScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/contact_us', page: () => const ContactUsScreen()),
        GetPage(name: '/report_success', page: () => const ReportSuccessScreen()),
        GetPage(
            name: '/privacy_policy', page: () => const PrivacyPolicyScreen()),
        GetPage(
            name: '/terms_conditions',
            page: () => const TermsConditionsScreen()),
        // GetPage(name: '/register_success', page: () => RegisterSuccessPage()),
        // GetPage(name: '/bottom_home', page: () => MyBottomNavigationPage()),
        // GetPage(name: '/order_confirm', page: () => OrderConfirmationPage()),
        // GetPage(name: '/orders', page: () => MyOrdersPage()),
        // GetPage(name: '/notifications', page: () => NotificationPage())
      ],
    );
  }
}