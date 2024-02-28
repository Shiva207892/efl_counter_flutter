import 'package:efl_counter/common/styles.dart';
import 'package:flutter/material.dart';
List<String> headers = ['Vehicles', 'Parking', 'Charging', 'Total'];

Widget buildHeaderRow() {
  return Row(
    children: List.generate(
      headers.length,
          (index) => Expanded(
        child: Container(
          color: Colors.white.withOpacity(0.75),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            headers[index],
            style: poppinsBold
          ),
        ),
      ),
    ),
  );
}