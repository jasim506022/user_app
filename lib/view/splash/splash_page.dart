import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';

import '../../res/app_asset/app_icons.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/app_asset/app_imges.dart';
import '../../res/apps_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage(AppImages.splashImage))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.appIcon,
                height: 100.h,
                width: 120.w,
                fit: BoxFit.fill,
              ),
              AppsFunction.verticalSpacing(10),
              Text(AppString.appsName, style: AppsTextStyle.appsLogoTextStyole),
            ],
          ),
        ),
      ),
    );
  }
}
