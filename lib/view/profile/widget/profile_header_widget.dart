import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_colors.dart';
import '../../../res/constants.dart';
import '../../../res/routes/routes_name.dart';
import '../../../res/textstyle.dart';
import '../../../widget/routes_button_widget.dart';

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
              Container(
                height: .15.sh,
                width: .15.sh,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.red, width: 3)),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(sharedPreference!.getString("imageurl")!),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(sharedPreference!.getString("name")!,
                          maxLines: 1,
                          style: Textstyle.largeText.copyWith(
                              fontSize: 20.sp,
                              color: Theme.of(context).primaryColor)),
                      Text(sharedPreference!.getString("email")!,
                          style: Textstyle.mediumText600.copyWith(
                              fontSize: 15.sp,
                              color: Theme.of(context).hintColor)),
                      SizedBox(
                        height: 8.h,
                      ),
                      RoutesButtonWidget(
                        title: "Edit Profile",
                        onTap: () {
                          Get.toNamed(RoutesName.editProfileScreen,
                              arguments: true);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
