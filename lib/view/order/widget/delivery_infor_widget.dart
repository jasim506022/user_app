import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_colors.dart';
import 'package:user_app/res/app_string.dart';

import '../../../model/order_model.dart';
import '../../../res/app_function.dart';
import 'delivery_card_widget.dart';
import 'delivery_rich_text_widget.dart';
import 'order_receiver_details_widget.dart';

class DeliveryInfoWidget extends StatelessWidget {
  const DeliveryInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DelivaryCardWidget(
          child: DeliveryRichTextWidget(
            title: "${AppString.deliveryPartner}:",
            subTitle: orderModel.deliveryPartner,
          ),
        ),
        AppsFunction.verticalSpacing(10),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: DeliveryRichTextWidget(
                title: "${AppString.trackingNumber} :",
                color: AppColors.red,
                subTitle: orderModel.trackingNumber)),
        AppsFunction.verticalSpacing(15),
        OrderReceiverDetailsWidget(orderModel: orderModel),
      ],
    );
  }
}
