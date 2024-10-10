import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/model/order_model.dart';
import 'package:user_app/res/appasset/image_asset.dart';

import 'widget/delivery_estimateion_card.dart';
import 'widget/delivery_infor_widget.dart';
import 'widget/order_product_details.dart';
import 'widget/order_status_widget.dart';

class OrderDeliveryScreen extends StatelessWidget {
  const OrderDeliveryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderModel orderModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Order Delivery ",
        ),
        elevation: 0.5,
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryEstimationCard(),
                ),
                SizedBox(
                  height: 15.h,
                ),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const DeliveryInfoWidget(),
                ),
                SizedBox(
                  height: 15.h,
                ),
                if (orderModel.status == "normal")
                  OrderStatusWidget(
                    image: ImagesAsset.readyForDelivery,
                    title: "Ready For Shifted",
                  ),
                if (orderModel.status == "shift")
                  OrderStatusWidget(
                    image: ImagesAsset.deliveryOrder,
                    title: "Product Ready for User",
                  ),
                if (orderModel.status == "complete")
                  OrderStatusWidget(
                    image: ImagesAsset.confirmOrder,
                    title: "Order is Successfully Done",
                  ),
                ChangeNotifierProvider.value(
                  value: orderModel,
                  child: const OrderProductDetails(),
                )
              ],
            ),
          )),
    );
  }
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/appasset/image_asset.dart';
import 'package:user_app/res/constants.dart';
import 'package:user_app/res/Textstyle.dart';
import 'package:user_app/view/order/order_detail_page.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

import '../../res/app_colors.dart';
import '../../model/productsmodel.dart';
import '../../model/profilemodel.dart';
import '../cart/loading_card_widget.dart';
import 'delivery_cart_widget.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen(
      {super.key, 
      
      // required this.orderId, required this.seperateQuantilies
      
      
      });
  // final String orderId;
  // final List<int> seperateQuantilies;
  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String orderStatus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery ",
        ),
        elevation: 0.5,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: StreamBuilder(
            stream: FirebaseDatabase.orderSnapshots(orderId: widget.orderId),
            builder: (context, snapshot) {
              Map? orderDataMap;
              if (snapshot.hasData) {
                orderDataMap = snapshot.data!.data();
                orderStatus = orderDataMap!["status"];
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PropabaleDevliaryCardWidget(orderDataMap: orderDataMap),
                      SizedBox(
                        height: 15.h,
                      ),
                      DelivaryDetailWidget(orderDataMap: orderDataMap),
                      const SizedBox(
                        height: 15,
                      ),
                      if (orderStatus == "normal")
                        OrderCurrentStatus(
                          image: ImagesAsset.readyForDelivery,
                          title: "Ready For Shifted",
                        ),
                      if (orderStatus == "shift")
                        OrderCurrentStatus(
                          image: ImagesAsset.deliveryOrder,
                          title: "Product Ready for User",
                        ),
                      OrderProductDetails(
                        orderDataMap: orderDataMap,
                        orderId: widget.orderId,
                        seperateQuantilies: widget.seperateQuantilies,
                        snapshot: snapshot,
                      )
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

class OrderProductDetails extends StatelessWidget {
  const OrderProductDetails({
    super.key,
    required this.orderDataMap,
    required this.orderId,
    required this.seperateQuantilies,
    required this.snapshot,
  });

  final Map? orderDataMap;
  final String orderId;
  final List<int> seperateQuantilies;
  final AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot;

  @override
  Widget build(BuildContext context) {
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
                "Order ${orderDataMap!["orderId"]}",
                style: Textstyle.largeText
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(
                          orderId: orderId,
                          addressId: orderDataMap!['addressId'],
                          order: orderDataMap!['productIds'],
                          itemQuantityList: seperateQuantilies,
                        ),
                      ));
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
          const SizedBox(
            height: 20,
          ),
          Flexible(
            child: FutureBuilder(
              future: FirebaseDatabase.deliveryOrderProductSnapshots(
                  sellerId: "", list: orderDataMap!['productIds']),
              builder: (context, productSnashot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productSnashot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return const LoadingCardWidget();
                    },
                  );
                } else if (productSnashot.hasData) {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: productSnashot.data!.docs.length,
                    itemBuilder: (context, itemIndex) {
                      ProductModel productModel = ProductModel.fromMap(
                          productSnashot.data!.docs[itemIndex].data());

                      return DeliveryCartWidget(
                        productModel: productModel,
                        itemQunter: seperateQuantilies[itemIndex],
                        index: itemIndex + 1,
                      );
                    },
                  );
                }
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const LoadingCardWidget();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderCurrentStatus extends StatelessWidget {
  const OrderCurrentStatus({
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
              style: Textstyle.largestText.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class DelivaryDetailWidget extends StatelessWidget {
  const DelivaryDetailWidget({
    super.key,
    required this.orderDataMap,
  });

  final Map? orderDataMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1.sw,
          padding: EdgeInsets.symmetric(vertical: 15.w),
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Text("Delivery Partner: ${orderDataMap!["deliverypartner"]}",
              style: Textstyle.mediumText600
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
                style: Textstyle.mediumText600.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              TextSpan(
                text: orderDataMap!["trackingnumber"],
                style: Textstyle.mediumText600.copyWith(),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25.h,
        ),
        StreamBuilder(
            stream: FirebaseDatabase.userDetails(),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasData) {
                ProfileModel profileModel =
                    ProfileModel.fromMap(userSnapshot.data!.data()!);

                return Container(
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(color: Theme.of(context).cardColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Receiver: ${profileModel.name!}",
                        style: Textstyle.mediumText600.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("0${profileModel.phone!}",
                          style: Textstyle.mediumText600
                              .copyWith(color: Theme.of(context).primaryColor)),
                      const SizedBox(
                        height: 15,
                      ),
                      StreamBuilder(
                          stream: FirebaseDatabase.orderAddressSnapsot(
                              addressId: orderDataMap!['addressId']),
                          builder: (context, addressSnashot) {
                            if (addressSnashot.hasData) {
                              return Text(
                                  addressSnashot.data!
                                      .data()!['completeaddress'],
                                  style: Textstyle.mediumText600.copyWith(
                                      color: Theme.of(context).hintColor));
                            }
                            return const Text("Address Not Found");
                          }),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            }),
      ],
    );
  }
}

class PropabaleDevliaryCardWidget extends StatelessWidget {
  const PropabaleDevliaryCardWidget({
    super.key,
    required this.orderDataMap,
  });

  final Map? orderDataMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.deepGreen,
          borderRadius: BorderRadius.circular(15.r)),
      height: 0.25.sh,
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        horizontal: 30.w,
        vertical: 30.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("On The way From Dhaka!", //28
              style: Textstyle.largestText
                  .copyWith(color: AppColors.white, fontSize: 28.sp)),
          SizedBox(
            height: 20.h,
          ),
          Text("Estimated Delivery Date is",
              style: Textstyle.largeText.copyWith(
                color: AppColors.white,
                fontSize: 17.sp,
              )),
          SizedBox(
            height: 20.h,
          ),
          Text(
            globalMethod.getFormateDate(
                context: context, datetime: orderDataMap!["deliverydate"]),
            style: Textstyle.largestText
                .copyWith(color: AppColors.white, fontSize: 28.sp),
          ),
        ],
      ),
    );
  }
}


*/