import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/order_model.dart';
import '../../../res/app_colors.dart';

import '../../../res/apps_text_style.dart';
import 'order_item_widget.dart';

class SellerProductWidget extends StatelessWidget {
  const SellerProductWidget({
    super.key,
    required this.sellerName,
    required this.orderModel,
    required this.sellerId,
  });

  final String sellerName;
  final OrderModel orderModel;
  final String sellerId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: RichText(
            text: TextSpan(
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: Theme.of(context).primaryColor),
              children: [
                const TextSpan(text: "Seller Name:\t"),
                TextSpan(
                  text: sellerName,
                  style: AppsTextStyle.largeBoldText
                      .copyWith(color: AppColors.red),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: OrderItemWidget(
            orderModel: orderModel,
            sellerId: sellerId,
          ),
          // child: ChangeNotifierProvider.value(
          //   value: orderModel,
          //   child: OrderItemWidget(
          //     sellerId: sellerId,
          //   ),
          // ),
        ),
      ],
    );
  }
}
