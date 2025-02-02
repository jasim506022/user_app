import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_colors.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/order_controller.dart';
import '../../../model/address_model.dart';
import '../../../model/order_model.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import 'delivery_card_widget.dart';
import 'delivery_rich_text_widget.dart';

class OrderReceiverDetailsWidget extends StatelessWidget {
  const OrderReceiverDetailsWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var orderController = Get.find<OrderController>();
    return StreamBuilder(
        stream: orderController.orderAddressSnapsot(
            addressId: orderModel.addressId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(
              "${AppString.errorOccure}: ${snapshot.error}",
              style: AppsTextStyle.mediumTextbold.copyWith(fontSize: 20),
            );
          }
          if (snapshot.hasData) {
            AddressModel addressModel =
                AddressModel.fromMap(snapshot.data!.data()!);

            return DelivaryCardWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DeliveryRichTextWidget(
                    title: "${AppString.receiver}:",
                    subTitle: addressModel.name!,
                  ),
                  AppsFunction.verticalSpacing(10),
                  DeliveryRichTextWidget(
                    title: "${AppString.phoneNumber}:",
                    subTitle: "0${addressModel.phone!}",
                    color: AppColors.red,
                  ),
                  AppsFunction.verticalSpacing(10),
                  Text(addressModel.completeaddress!,
                      style: AppsTextStyle.mediumNormalText
                          .copyWith(color: Theme.of(context).hintColor))
                ],
              ),
            );
          }
          return Text(
            AppString.noDataAvailable,
            style: AppsTextStyle.labelTextStyle,
          );
        });
  }
}
