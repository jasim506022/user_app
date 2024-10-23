import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/constant/string_constant.dart';
import '../../../res/constants.dart';
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
              SizedBox(
                width: 30.w,
              ),
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
        Text(sharedPreference!.getString(StringConstant.nameSharedPreference)!,
            maxLines: 1, style: AppsTextStyle.titleTextStyle),
        Text(sharedPreference!.getString(StringConstant.emailSharedPreference)!,
            style: AppsTextStyle.subTitleTextStyle),
        SizedBox(
          height: 8.h,
        ),
        CustomRoundActionButton(
          title: "Edit Profile",
          onTap: () async {
            if (!(await AppsFunction.verifyInternetStatus())) {
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
      child: CircleAvatar(
        backgroundImage: NetworkImage(
            sharedPreference!.getString(StringConstant.imageSharedPreference)!),
      ),
    );
  }
}
