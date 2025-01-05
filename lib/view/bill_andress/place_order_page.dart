import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/profile_controller.dart';
import 'package:user_app/res/app_asset/image_asset.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';
import 'package:user_app/res/routes/routes_name.dart';

import '../../res/app_colors.dart';
import '../../res/apps_text_style.dart';

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage({
    super.key,
  });

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  var profileController = Get.find<ProfileController>();
  @override
  void initState() {
    profileController.getUserInformationSnapshot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppString.yourOrderIsConfirm,
            style: AppsTextStyle.titleTextStyle.copyWith(fontSize: 24.sp),
          ),
          AppsFunction.verticleSpace(15),
          Text(
            AppString.thankyouforshopping,
            style: AppsTextStyle.largeBoldText,
          ),
          Image.asset(ImagesAsset.confirmOrder),
          AppsFunction.verticleSpace(5),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGreen,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 25.w)),
              onPressed: () {
                Get.offAllNamed(RoutesName.mainPage, arguments: 0);
              },
              child: Text(AppString.homePage,
                  style: AppsTextStyle.buttonTextStyle))
        ],
      ),
    );
  }
}
