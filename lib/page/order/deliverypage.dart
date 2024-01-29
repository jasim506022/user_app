import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/const/const.dart';
import 'package:user_app/const/textstyle.dart';
import 'package:user_app/page/order/orderdetailpage.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

import '../../const/gobalcolor.dart';
import '../../model/productsmodel.dart';
import '../../model/profilemodel.dart';
import '../cart/loadingcardwidget.dart';
import 'delivery_cart_widget.dart';

class DeliveryScreen extends StatefulWidget {
  const DeliveryScreen(
      {super.key, required this.orderId, required this.seperateQuantilies});
  final String orderId;
  final List<int> seperateQuantilies;
  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  String orderStatus = "";

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Delivery Details",
        ),
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                      Container(
                        height: mqs(context).height * .3,
                        width: mqs(context).width,
                        color: deepGreen,
                        padding: const EdgeInsets.only(
                            left: 30, top: 40, bottom: 40, right: 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("On The way From Dhaka!",
                                style: textstyle.largestText
                                    .copyWith(color: white, fontSize: 28)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text("Estimated Delivery Date is",
                                style: textstyle.largeText.copyWith(
                                  color: white,
                                  fontSize: 17,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              globalMethod.getFormateDate(
                                  context: context,
                                  datetime: orderDataMap["deliverydate"]),
                              style: textstyle.largestText
                                  .copyWith(color: white, fontSize: 28),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: mqs(context).width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 20),
                        decoration:
                            BoxDecoration(color: Theme.of(context).cardColor),
                        child: Text(
                            "Delivery Partner: ${orderDataMap["deliverypartner"]}",
                            style: textstyle.mediumText600.copyWith(
                                color: Theme.of(context).primaryColor)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Tracking Number : ",
                              style: textstyle.mediumText600.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: orderDataMap["trackingnumber"],
                              style: textstyle.mediumText600.copyWith(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      StreamBuilder(
                          stream: FirebaseDatabase.userDetails(),
                          builder: (context, userSnapshot) {
                            if (userSnapshot.hasData) {
                              ProfileModel profileModel = ProfileModel.fromMap(
                                  userSnapshot.data!.data()!);
                              return Container(
                                width: mqs(context).width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Receiver: ${profileModel.name!}",
                                      style: textstyle.mediumText600.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(profileModel.phone!,
                                        style: textstyle.mediumText600.copyWith(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    StreamBuilder(
                                        stream: FirebaseDatabase
                                            .orderAddressSnapsot(
                                                addressId:
                                                    orderDataMap!['addressId']),
                                        builder: (context, addressSnashot) {
                                          if (addressSnashot.hasData) {
                                            return Text(
                                                addressSnashot.data!
                                                    .data()!['completeaddress'],
                                                style: textstyle.mediumText600
                                                    .copyWith(
                                                        color: Theme.of(context)
                                                            .hintColor));
                                          }
                                          return const Text(
                                              "Address Not Found");
                                        }),
                                  ],
                                ),
                              );
                            }
                            return const CircularProgressIndicator();
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      if (orderStatus == "normal")
                        Container(
                          padding: const EdgeInsets.all(15),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Image.asset(
                                "asset/order/readyfordeliver.png",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: deepGreen,
                                ),
                                child: Text(
                                  "Ready For Shifted",
                                  style: textstyle.largestText
                                      .copyWith(color: white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (orderStatus == "complete")
                        Container(
                          padding: const EdgeInsets.all(15),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            children: [
                              Image.asset(
                                "asset/order/doneorder.png",
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 45, vertical: 15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: deepGreen,
                                ),
                                child: Text(
                                  "Order Delivery Complete",
                                  style: textstyle.largestText
                                      .copyWith(color: white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (orderStatus == "complete")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Please Ratting Product",
                                style: textstyle.largestText,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Flexible(
                                child: FutureBuilder(
                                  future: FirebaseDatabase
                                      .deliveryOrderProductSnapshots(
                                          list: orderDataMap['productIds']),
                                  builder: (context, productSnashot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return const LoadingCardWidget();
                                        },
                                      );
                                    } else if (productSnashot.hasData) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, itemIndex) {
                                          ProductModel productModel =
                                              ProductModel.fromMap(
                                                  productSnashot
                                                      .data!.docs[itemIndex]
                                                      .data());

                                          return DeliveryCartWidget(
                                            productModel: productModel,
                                            itemQunter: widget
                                                .seperateQuantilies[itemIndex],
                                            index: itemIndex + 1,
                                          );
                                        },
                                      );
                                    }
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                        ),
                      if (orderStatus == "normal")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          color: Theme.of(context).cardColor,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order ${orderDataMap["orderId"]}",
                                    style: textstyle.largeText.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrderDetailsPage(
                                              orderId: widget.orderId,
                                              addressId:
                                                  orderDataMap!['addressId'],
                                              order: orderDataMap['productIds'],
                                              itemQuantityList:
                                                  widget.seperateQuantilies,
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      "Order Details >",
                                      style: GoogleFonts.roboto(
                                          fontSize: 13,
                                          color: red,
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
                                  future: FirebaseDatabase
                                      .deliveryOrderProductSnapshots(
                                          list: orderDataMap['productIds']),
                                  builder: (context, productSnashot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, index) {
                                          return const LoadingCardWidget();
                                        },
                                      );
                                    } else if (productSnashot.hasData) {
                                      return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            productSnashot.data!.docs.length,
                                        itemBuilder: (context, itemIndex) {
                                          ProductModel productModel =
                                              ProductModel.fromMap(
                                                  productSnashot
                                                      .data!.docs[itemIndex]
                                                      .data());

                                          return DeliveryCartWidget(
                                            productModel: productModel,
                                            itemQunter: widget
                                                .seperateQuantilies[itemIndex],
                                            index: itemIndex + 1,
                                          );
                                        },
                                      );
                                    }
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
