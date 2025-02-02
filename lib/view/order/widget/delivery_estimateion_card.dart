import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/order_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';

class DeliveryEstimationCard extends StatelessWidget {
  const DeliveryEstimationCard({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
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
          Text(AppString.onTheWayFromDahaka,
              style: AppsTextStyle.orderDateCard),
          AppsFunction.verticalSpacing(10),
          Text(AppString.estimatedDeliveryDate,
              style: AppsTextStyle.largeText.copyWith(
                color: AppColors.white,
              )),
          AppsFunction.verticalSpacing(20),
          Text(
            AppsFunction.formatDeliveryDate(datetime: orderModel.deliveryDate),
            style: AppsTextStyle.orderDateCard,
          ),
        ],
      ),
    );
  }
}
