import 'package:efl_counter/widgets/base_gradient.dart';
import 'package:flutter/material.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: baseGradientContainer(context, const Text('Reports Sent Successfully')),
      )
    );
  }
}