import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/app_string.dart';

import '../../../model/order_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';

class DeliveryEstimationCard extends StatelessWidget {
  const DeliveryEstimationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);

    return Container(
      decoration: BoxDecoration(
          color: AppColors.deepGreenAccent,
          borderRadius: BorderRadius.circular(15.r)),
      height: 0.27.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 30.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppString.onTheWayFromDahaka, //28
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: AppColors.white, fontSize: 28.sp)),
          AppsFunction.verticleSpace(10),
          Text(AppString.estimatedDeliveryDate,
              style: AppsTextStyle.largeText.copyWith(
                color: AppColors.white,
              )),
          AppsFunction.verticleSpace(20),
          Text(
            AppsFunction.formatDeliveryDate(datetime: orderModel.deliveryDate),
            style: AppsTextStyle.largestText
                .copyWith(color: AppColors.white, fontSize: 28.sp),
          ),
        ],
      ),
    );
  }
}
