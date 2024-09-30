import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/app_colors.dart';
import '../../../res/constants.dart';
import '../../../res/routes/routesname.dart';
import '../../../res/textstyle.dart';

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
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.greenColor),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(RoutesName.editProfileScreen,
                                arguments: true);
                          },
                          child: Text(
                            "Edit Profile",
                            style: GoogleFonts.poppins(
                              color: AppColors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
