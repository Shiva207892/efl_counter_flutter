import 'package:efl_counter/widgets/base_gradient.dart';
import 'package:efl_counter/widgets/top_map_selector.dart';
import 'package:flutter/material.dart';

import '../../widgets/data_input_table.dart';

class AddDataScreen extends StatelessWidget {
  const AddDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(child: baseGradientContainer(context,
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const TopCustomerSelector(),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextInputTable(
                    controllersList: List.generate(
                      6,
                          (_) => TextEditingController()
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}