import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


import '../../../model/order_model.dart';
import '../../../res/apps_text_style.dart';
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
        Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(vertical: 15.w),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Text("Delivery Partner: ${orderModel.deliveryPartner}",
              style: AppsTextStyle.mediumText600
                  .copyWith(color: Theme.of(context).primaryColor)),
        ),
        SizedBox(
          height: 10.h,
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Tracking Number : ",
                style: AppsTextStyle.mediumText600.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextSpan(
                text: orderModel.trackingNumber,
                style: AppsTextStyle.mediumText600.copyWith(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        OrderReceiverDetailsWidget(orderModel: orderModel),
      ],
    );
  }
}
