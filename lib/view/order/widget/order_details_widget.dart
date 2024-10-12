import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/order_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order #${orderModel.orderId}",
              style: AppsTextStyle.largeBoldText.copyWith(
                color: AppColors.greenColor,
              )),
          SizedBox(
            height: 7.w,
          ),
          Text(
              "Placed On ${AppsFunction.formatDeliveryDate(datetime: orderModel.orderId)}",
              style: AppsTextStyle.mediumText600
                  .copyWith(color: Theme.of(context).hintColor)),
          SizedBox(
            height: 25.h,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.greenColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w)),
                onPressed: () {
                  Get.offAndToNamed(RoutesName.mainPage, arguments: 0);
                },
                child: Text(
                  "Home Page",
                  style: AppsTextStyle.largestText
                      .copyWith(color: AppColors.white, fontSize: 15.sp),
                )),
          )
        ],
      ),
    );
  }
}
