import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/routes_name.dart';
import 'package:user_app/view/order/widget/order_item_widget.dart';

import '../../../model/order_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';

class OrderProductDetails extends StatelessWidget {
  const OrderProductDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orderModel = Provider.of<OrderModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      color: Theme.of(context).cardColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order ${orderModel.orderId}",
                style: AppsTextStyle.largeText
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(RoutesName.orderDetailsPage,
                      arguments: orderModel);
                },
                child: Text(
                  "Order Details >",
                  style: GoogleFonts.roboto(
                      fontSize: 13,
                      color: AppColors.red,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          Flexible(
            child: ChangeNotifierProvider.value(
              value: orderModel,
              child: const OrderItemWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
