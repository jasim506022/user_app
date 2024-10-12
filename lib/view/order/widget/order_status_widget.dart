import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
    required this.image,
    required this.title,
  });
  final String image;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.r),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          Image.asset(image, height: 200.h, width: 1.sw),
          SizedBox(
            height: 15.h,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.deepGreen,
            ),
            child: Text(
              title,
              style: AppsTextStyle.largestText.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
