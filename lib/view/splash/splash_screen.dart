import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

import '../../res/app_asset/app_icons.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/app_asset/image_asset.dart';
import '../../res/apps_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Get.find<SplashController>();

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
                AppIcons.appIcon,
                height: 0.15.sh,
                width: 0.15.sh,
              ),
              AppsFunction.verticleSpace(10),
              Text(AppString.groceryApps, style: AppsTextStyle.appLogoFonts),
            ],
          ),
        ),
      ),
    );
  }
}
