import 'package:efl_counter/utils/app_colors.dart';
import 'package:efl_counter/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomDialogTwoActioned(BuildContext context, String title, String message, String positiveAction, void Function() onConfirm, String negativeAction, void Function() onCancel) {
  var titleStyle = GoogleFonts.inter(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w500, color: AppColors.primaryColor);
  var messageStyle = GoogleFonts.inter(fontSize: Dimensions.fontSizeDefault, fontWeight: FontWeight.w500);
  var actionStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryColor
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(child: Text(title, style: titleStyle)),
        content: Text(message, style: messageStyle),
        actions: <Widget>[
          ElevatedButton(
            style: actionStyle,
            onPressed: onCancel,
            child: Text(negativeAction),
          ),
          ElevatedButton(
            style: actionStyle,
            onPressed: onConfirm,
            child: Text(positiveAction),
          ),
        ],
      );
    },
  );
}

class FlatButton {
}