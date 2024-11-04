import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/controller/profile_controller.dart';
import 'package:user_app/res/appasset/image_asset.dart';
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
            "Your order is confirmed",
            style: AppsTextStyle.titleTextStyle.copyWith(fontSize: 24.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Thank you for shopping with JU Grocery",
            style: GoogleFonts.roboto(
                color: Theme.of(context).primaryColor,
                fontSize: 22.sp,
                fontWeight: FontWeight.normal),
          ),
          Image.asset(ImagesAsset.confirmOrder),
          SizedBox(
            height: 4.h,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greenColor,
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 25.w)),
              onPressed: () {
                Get.offAllNamed(RoutesName.mainPage, arguments: 0);
              },
              child: Text(
                "Home Page",
                style: AppsTextStyle.largestText
                    .copyWith(color: AppColors.white, fontSize: 20.sp),
              ))
        ],
      ),
    );
  }
}
