import 'package:efl_counter/utils/dimensions.dart';
import 'package:efl_counter/widgets/top_map_selector.dart';
import 'package:flutter/material.dart';

class AddDataScreen extends StatelessWidget {
  const AddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                topMapSelector(context),
              ],
            )
          ],
        ),
      )),
    );
  }
}
