import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../res/appasset/icon_asset.dart';
import '../../res/appasset/image_asset.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return Material(
      child: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImagesAsset.splashImage), fit: BoxFit.fill),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconAsset.appIcon,
                height: 0.176.sh,
                width: 0.176.sh,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text("Grocery Apps",
                  style: Textstyle.largestText.copyWith(
                      color: AppColors.greenColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
