import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/view/home/widget/network_utili.dart';

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
        height: 0.18.sh,
        width: 1.sw,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              _buildProfileImage(),
              AppsFunction.horizontalSpace(30),
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
            style: AppsTextStyle.subTitleTextStyle),
        AppsFunction.verticleSpace(8),
        CustomRoundActionButton(
          title: AppString.editProfile,
          onTap: () async {
            if (!(await NetworkUtili.verifyInternetStatus())) {
              Get.toNamed(RoutesName.editProfileScreen, arguments: true);
            }
          },
        )
      ],
    );
  }

  Container _buildProfileImage() {
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
