import 'package:efl_counter_flutter/utils/app_colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: AppColors.primaryColor,
    body: SafeArea(child: SingleChildScrollView(

    )),
    );
  }
}
