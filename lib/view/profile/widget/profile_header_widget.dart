import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/network_utili.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_constant.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';

import '../../../res/routes/routes_name.dart';

import '../../../widget/custom_round_action_button.dart';

class ProifleHeaderWidget extends StatelessWidget {
  const ProifleHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 155.h,
        width: 1.sw,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              const CircleImageWidget(),
              AppsFunction.horizontalSpacing(30),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: _buildProfileDetails(),
                ),
              )
            ],
          ),
        ));
  }

  Column _buildProfileDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
            AppConstant.sharedPreference!
                .getString(AppString.nameSharedPreference)!,
            maxLines: 1,
            style: AppsTextStyle.titleTextStyle),
        Text(
            AppConstant.sharedPreference!
                .getString(AppString.emailSharedPreference)!,
            style: AppsTextStyle.subtitleTextStyle),
        AppsFunction.verticalSpacing(8),
        CustomRoundActionButton(
          title: AppString.editProfile,
          onTap: () async {
            NetworkUtils.executeWithInternetCheck(action: () {
              Get.toNamed(AppRoutesName.editProfilePage, arguments: true);
            });
/*
            if (!(await NetworkUtili.verifyInternetStatus())) {
              Get.toNamed(AppRoutesName.editProfilePage, arguments: true);
            }
            */
          },
        )
      ],
    );
  }

  // Container _buildProfileImage() {
  //   return ;
  // }
}

class CircleImageWidget extends StatelessWidget {
  const CircleImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: .15.sh,
        width: .15.sh,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 3.w)),
        child: ClipOval(
          child: FancyShimmerImage(
            imageUrl: AppConstant.sharedPreference!
                .getString(AppString.imageSharedPreference)!,
            errorWidget: const Icon(Icons.error),
          ),
        ));
  }
}
