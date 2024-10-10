
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/order_controller.dart';
import '../../../model/address_model.dart';
import '../../../model/order_model.dart';
import '../../../res/textstyle.dart';


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
              "Error: ${snapshot.error}",
              style: Textstyle.mediumTextbold.copyWith(fontSize: 20),
            );
          }
          if (snapshot.hasData) {
            AddressModel addressModel =
                AddressModel.fromMap(snapshot.data!.data()!);

            return Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(vertical: 20.h),
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Receiver: ${addressModel.name!}",
                    style: Textstyle.mediumText600.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text("0${addressModel.phone!}",
                      style: Textstyle.mediumText600
                          .copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(addressModel.completeaddress!,
                      style: Textstyle.mediumText600
                          .copyWith(color: Theme.of(context).hintColor))
                ],
              ),
            );
          }
          return Text(
            "No Address is Avaiable",
            style: Textstyle.mediumTextbold.copyWith(fontSize: 20),
          );
        });
  }
}
