import 'package:efl_counter_flutter/controllers/app_controller.dart';
import 'package:efl_counter_flutter/utils/app_pictures.dart';
import 'package:efl_counter_flutter/utils/dimensions.dart';
import 'package:efl_counter_flutter/widgets/base_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/app_colors.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<AppController>().setCurrentPageIndex(0);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(child:
            baseGradientContainer(context,
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeLargest),
                  child: Column(children: [
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                              AppPictures.contactUsIcon
                          ))
                      ),
                    )),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                      child: Container(
                        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Technical Issue', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('connect@electricfuel.co.in', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          SizedBox(height: Dimensions.paddingSizeLargest),

                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('+91 8121002815 (Kashinath)', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('+91 8121009283 (Sriman)', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.w300),),
                            ],
                          ),
                          SizedBox(height: Dimensions.paddingSizeLargest),

                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Official web', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.bold),),
                            ],
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('www.electricfuel.co.in', style: GoogleFonts.inter(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.w300),),
                            ],
                          ),

                        ],),
                      ),
                    )),
                    SizedBox(height: Dimensions.paddingSizeLargest),
                  ],),
                )
            )
        ),
      ),
    );
  }
}
