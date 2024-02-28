import 'package:efl_counter/common/styles.dart';
import 'package:flutter/material.dart';
import '../../../utils/app_pictures.dart';
import '../../../utils/dimensions.dart';

const List<String> vehicleIcons = [AppPictures.scooterIcon, AppPictures.autoIcon, AppPictures.taxiIcon];
Widget buildVehicleColumn(BuildContext context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width * 0.22,
    child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Set physics to prevent scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 5.0,
          mainAxisSpacing: 5.0,
          childAspectRatio: 1.25,
        ),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration:
              BoxDecoration(
                  color: Colors.white.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(vehicleIcons[index], width: 36, height: 36,),
                    Text('${index+2} Wheeler', style: poppinsBold)
                  ],
                ),
              ));
        }),
  );

  // return Column(
  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //   children: [
  //     _buildIconCell(0),
  //     _buildIconCell(1),
  //     _buildIconCell(2),
  //   ],
  // );
}