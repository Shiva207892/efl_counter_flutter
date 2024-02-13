import 'package:efl_counter/utils/app_pictures.dart';
import 'package:flutter/material.dart';

Widget authTopImage(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.35,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(AppPictures.topBanner)
      )
    ),
  );
}