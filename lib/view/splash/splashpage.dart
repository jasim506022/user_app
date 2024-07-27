import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/splash_controller.dart';
import 'package:user_app/res/appasset/icon_asset.dart';
import 'package:user_app/res/appasset/image_asset.dart';

import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController(
      repository: Get.find(),
    ));

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Textstyle Textstyle = Textstyle(context);
    return Material(
      child: Container(
        height: mq.height,
        width: mq.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagesAsset.splashImage),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconAsset.appIcon,
                height: mq.height * .176,
                width: mq.height * .176,
              ),
              Text("Grocery Apps",
                  style: Textstyle.largestText
                      .copyWith(color: AppColors.greenColor, fontSize: 22)),
            ],
          ),
        ),
      ),
    );
  }
}
