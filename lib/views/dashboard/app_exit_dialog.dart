import 'package:efl_counter/utils/app_pictures.dart';
import 'package:flutter/material.dart';

import '../../common/styles.dart';
import '../../utils/dimensions.dart';
import '../../widgets/custom_button.dart';

class AppExitDialog extends StatelessWidget {
  const AppExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(AppPictures.electricFuelIcon)),
          ),
          //SizedBox(height: Dimensions.paddingSizeLarge),

          // fromCheckout ? Text(
          //   getTranslated('order_placed_successfully', context),
          //   style: poppinsMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
          // ) : SizedBox(),
          // SizedBox(height: fromCheckout ? Dimensions.paddingSizeSmall : 0),

          const SizedBox(height: 30),

          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.exit_to_app, color: Theme.of(context).primaryColor),
            Text(
              'Exit Alert!',
              style:
              poppinsMedium.copyWith(color: Theme.of(context).primaryColor),
            ),
          ]),
          const SizedBox(height: 10),

          Text(
            'Do you want to exit the app?',
            style: poppinsRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          Row(children: [
            Expanded(
                child: CustomButton(
                    buttonText: 'Exit',
                    onTap: () {
                      Navigator.pop(context, true);
                    })),
            const SizedBox(width: 10),
            Expanded(
                child: CustomButton(
                    buttonText: 'Cancel',
                    onTap: () {
                      Navigator.pop(context, false);
                    })),
          ]),
        ]),
      ),
    );
  }
}
