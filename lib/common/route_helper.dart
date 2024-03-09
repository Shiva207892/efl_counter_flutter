import 'package:get/get.dart';

import '../views/authentication/login_screen.dart';
import '../views/authentication/otp_screen.dart';
import '../views/authentication/splash_screen.dart';
import '../views/dashboard/home_screen.dart';
import '../views/drawer/contact_us_screen.dart';
import '../views/drawer/privacy_policy_screen.dart';
import '../views/drawer/profile_screen.dart';
import '../views/drawer/report_success_screen.dart';
import '../views/drawer/terms_conditions_screen.dart';
import '../views/screens/add_data_screen.dart';

class RouteHelper {
  static String splash = '/';
  static String login = '/login';
  static String otp = '/otp';
  static String home = '/home';
  static String addData = '/add_data';
  static String profile = '/profile';
  static String contactUs = '/contact_us';
  static String reportSuccess = '/report_success';
  static String pvcPolicy = '/privacy_policy';
  static String tncCondition = '/terms_conditions';

  static List<GetPage> appPages = [
  GetPage(name: splash, page: () => const SplashScreen()),
  GetPage(name: login, page: () => const LoginScreen()),
  GetPage(name: otp, page: () => const OtpScreen()),
  GetPage(name: home, page: () => const HomeScreen()),
  GetPage(name: addData, page: () => const AddDataScreen()),
  GetPage(name: profile, page: () => const ProfileScreen()),
  GetPage(name: contactUs, page: () => const ContactUsScreen()),
  GetPage(name: reportSuccess, page: () => const ReportSuccessScreen()),
  GetPage(
  name: pvcPolicy, page: () => const PrivacyPolicyScreen()),
  GetPage(
  name: tncCondition,
  page: () => const TermsConditionsScreen()),
  // GetPage(name: '/register_success', page: () => RegisterSuccessPage()),
  // GetPage(name: '/bottom_home', page: () => MyBottomNavigationPage()),
  // GetPage(name: '/order_confirm', page: () => OrderConfirmationPage()),
  // GetPage(name: '/orders', page: () => MyOrdersPage()),
  // GetPage(name: '/notifications', page: () => NotificationPage())
  ];
}