import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:user_app/controller/cart_controller.dart';
import 'package:user_app/res/appasset/image_asset.dart';

import '../../res/app_function.dart';
import '../../res/cart_funtion.dart';
import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../model/productsmodel.dart';
import '../../res/utils.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/totalamountrpovider.dart';
import '../../widget/empty_widget.dart';
import '../bill/billlscreen.dart';
import 'cart_widget.dart';
import 'dot_line_printer.dart';
import 'loading_card_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int>? productQuantityListFromCartList;
  double totalAmountPerSeller = 0;

  double totalAmount = 0.0;
  double deliveryAmount = 50;

  var cartController = Get.put(CartController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      totalAmount = 0;
      cartController.totalAmountController.setAmount(0);

      productQuantityListFromCartList =
          CartFunctions.separteProductQuantityUserCartList();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Cart Item")),
      body: sharedPreference!.getStringList("cartlist")!.length == 1 &&
              sharedPreference!.getStringList("cartlist")!.first == "initial"
          ? EmptyWidget(
              image: ImagesAsset.error,
              title: "No Cart Avaiable",
            )
          : Obx(() {
              final stream = cartController.cartStream.value;
              totalAmount = 0;
              totalAmountPerSeller = 0;
              if (stream == null) {
                return CircularProgressIndicator();
              }
              if (cartController.shareP.value == 1) {
                return EmptyWidget(
                  image: ImagesAsset.error,
                  title: "No Cart Avaiable",
                );
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .55,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: stream,
                        // FirebaseDatabase.cartSellerSnapshot(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const EmptyWidget(
                              image: 'asset/payment/empty.png',
                              title: 'No User Available',
                            );
                          } else if (snapshot.hasError) {
                            return EmptyWidget(
                              image: 'asset/payment/empty.png',
                              title: 'Error Occure: ${snapshot.error}',
                            );
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                var sellerId =
                                    snapshot.data!.docs[index]["name"];
                                cartController.cartproductSnapshot(
                                    sellerId: snapshot.data!.docs[index]
                                        ['uid']);

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: RichText(
                                          text: TextSpan(
                                              style: Textstyle.largestText,
                                              children: [
                                            const TextSpan(
                                                text: "Seller Name:\t"),
                                            TextSpan(
                                              text: sellerId,
                                              style: Textstyle.largestText
                                                  .copyWith(
                                                      color: AppColors.red),
                                            )
                                          ])),
                                    ),
                                    Flexible(
                                      child: StreamBuilder(
                                        stream: cartController
                                            .cartProductSnapshots.value,
                                        builder: (context, productSnashot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const LoadingCardWidget();
                                          } else if (productSnashot.hasData) {
                                            return ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: productSnashot
                                                  .data!.docs.length,
                                              itemBuilder:
                                                  (context, itemIndex) {
                                                ProductModel productModel =
                                                    ProductModel.fromMap(
                                                        productSnashot.data!
                                                            .docs[itemIndex]
                                                            .data());

                                                totalAmountPerSeller +=
                                                    AppsFunction.productPrice(
                                                          productModel
                                                              .productprice!,
                                                          productModel.discount!
                                                              .toDouble(),
                                                        ) *
                                                        productQuantityListFromCartList![
                                                            itemIndex];

                                                WidgetsBinding.instance
                                                    .addPostFrameCallback(
                                                        (timeStamp) {
                                                  // Provider.of<TotalAmountProvider>(
                                                  //         context,
                                                  //         listen: false)
                                                  //     .setAmount(
                                                  //         totalAmountPerSeller);
                                                  cartController
                                                      .totalAmountController
                                                      .setAmount(
                                                          totalAmountPerSeller);
                                                });

                                                if (kDebugMode) {
                                                  print(
                                                      "${totalAmountPerSeller}Bangladesh");
                                                }

                                                // if (itemIndex == 0) {
                                                //   totalAmount = 0;
                                                //   totalAmount = totalAmount +
                                                //       (globalMethod.productPrice(
                                                //               productModel
                                                //                   .productprice!,
                                                //               productModel.discount!
                                                //                   .toDouble()) *
                                                //           productQuantityListFromCartList![
                                                //               itemIndex]);
                                                // } else {
                                                //   totalAmount = totalAmount +
                                                //       (globalMethod.productPrice(
                                                //               productModel
                                                //                   .productprice!,
                                                //               productModel.discount!
                                                //                   .toDouble()) *
                                                //           productQuantityListFromCartList![
                                                //               itemIndex]);
                                                // }

                                                if (snapshot.data!.docs.length -
                                                        1 ==
                                                    itemIndex) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback(
                                                          (timeStamp) {
                                                    // Provider.of<TotalAmountProvider>(
                                                    //         context,
                                                    //         listen: false)
                                                    //     .setAmount(
                                                    //         totalAmountPerSeller);
                                                    cartController
                                                        .totalAmountController
                                                        .setAmount(
                                                            totalAmountPerSeller);
                                                  });
                                                }

                                                print(productModel.productname
                                                        .toString() +
                                                    productModel.productId
                                                        .toString() +
                                                    "Item Index" +
                                                    itemIndex.toString());

                                                // if (snapshot.data!.docs.length -
                                                //         1 ==
                                                //     itemIndex) {
                                                //   WidgetsBinding.instance
                                                //       .addPostFrameCallback(
                                                //           (timeStamp) {
                                                //     Provider.of<TotalAmountProvider>(
                                                //             context,
                                                //             listen: false)
                                                //         .setAmount(totalAmount);
                                                //   });
                                                // }
                                                return CardWidget(
                                                  productModel: productModel,
                                                  itemQunter:
                                                      productQuantityListFromCartList![
                                                          itemIndex],
                                                  index: itemIndex + 1,
                                                );
                                              },
                                            );
                                          }
                                          return ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: 3,
                                              itemBuilder:
                                                  (context, itemIndex) {
                                                return const LoadingCardWidget();
                                              });
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                    Expanded(
                      child: Container(
                          height: MediaQuery.of(context).size.height * .35,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: utils.bottomTotalBill,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                          child: Obx(() {
                            totalAmount += cartController
                                .totalAmountController.amount.value;
                            if (kDebugMode) {
                              print(totalAmount.toString());
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Amount",
                                        style: Textstyle.mediumText600.copyWith(
                                            color:
                                                Theme.of(context).hintColor)),
                                    Text(
                                      "Tk ${cartController.totalAmountController.amount.value.toString()}",
                                      style: Textstyle.mediumTextbold.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Delivery Charge",
                                        style: Textstyle.mediumText600.copyWith(
                                            color:
                                                Theme.of(context).hintColor)),
                                    Text(
                                      deliveryAmount.toString(),
                                      style: Textstyle.mediumTextbold.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Carry Bag Charge",
                                      style: Textstyle.mediumText600.copyWith(
                                          color: Theme.of(context).hintColor),
                                    ),
                                    Text(
                                      "0.00",
                                      style: Textstyle.mediumTextbold.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width, // Adjust the width as needed
                                  child: CustomPaint(
                                    painter: DottedLinePainter(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Sub Total",
                                      style: Textstyle.mediumTextbold.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                    ),
                                    Text(
                                      "${cartController.totalAmountController.amount.value + deliveryAmount}",
                                      style: Textstyle.mediumTextbold.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const BillPage(),
                                        ));
                                  },
                                  child: Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: AppColors.greenColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      "Continue",
                                      style: Textstyle.mediumTextbold
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          })),
                    )
                  ],
                );
              }
            }),
    );
  }
}

/*

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int>? productQuantityListFromCartList;
  double totalAmountPerSeller = 0;

  double totalAmount = 0.0;
  double deliveryAmount = 50;

  @override
  void initState() {
    totalAmount = 0;
    Provider.of<TotalAmountProvider>(context, listen: false).setAmount(0);
    productQuantityListFromCartList =
        CartMethods.separteProductQuantityUserCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    // Textstyle Textstyle = Textstyle(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Cart Item")),
      body: sharedPreference!.getStringList("cartlist")!.length == 1 &&
              sharedPreference!.getStringList("cartlist")!.first == "initial"
          ? const EmptyWidget(
              image: "asset/payment/empty.png",
              title: "No Cart Avaiable",
            )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .55,
                  child: StreamBuilder(
                    stream: FirebaseDatabase.cartSellerSnapshot(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'No User Available',
                        );
                      } else if (snapshot.hasError) {
                        return EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'Error Occure: ${snapshot.error}',
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var sellerId = snapshot.data!.docs[index]["name"];

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: RichText(
                                      text: TextSpan(
                                          style: Textstyle.largestText,
                                          children: [
                                        const TextSpan(text: "Seller Name:\t"),
                                        TextSpan(
                                          text: sellerId,
                                          style: Textstyle.largestText
                                              .copyWith(color:AppColors. red),
                                        )
                                      ])),
                                ),
                                Flexible(
                                  child: StreamBuilder(
                                    stream:
                                        FirebaseDatabase.cartProductSnapshot(
                                            sellerId: snapshot.data!.docs[index]
                                                ['uid']),
                                    builder: (context, productSnashot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const LoadingCardWidget();
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
                                            totalAmountPerSeller += AppsFunction
                                                    .productPrice(
                                                  productModel.productprice!,
                                                  productModel.discount!
                                                      .toDouble(),
                                                ) *
                                                productQuantityListFromCartList![
                                                    itemIndex];

                                            // if (itemIndex == 0) {
                                            //   totalAmount = 0;
                                            //   totalAmount = totalAmount +
                                            //       (globalMethod.productPrice(
                                            //               productModel
                                            //                   .productprice!,
                                            //               productModel.discount!
                                            //                   .toDouble()) *
                                            //           productQuantityListFromCartList![
                                            //               itemIndex]);
                                            // } else {
                                            //   totalAmount = totalAmount +
                                            //       (globalMethod.productPrice(
                                            //               productModel
                                            //                   .productprice!,
                                            //               productModel.discount!
                                            //                   .toDouble()) *
                                            //           productQuantityListFromCartList![
                                            //               itemIndex]);
                                            // }

                                            if (snapshot.data!.docs.length -
                                                    1 ==
                                                itemIndex) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (timeStamp) {
                                                Provider.of<TotalAmountProvider>(
                                                        context,
                                                        listen: false)
                                                    .setAmount(
                                                        totalAmountPerSeller);
                                              });
                                            }

                                            // if (snapshot.data!.docs.length -
                                            //         1 ==
                                            //     itemIndex) {
                                            //   WidgetsBinding.instance
                                            //       .addPostFrameCallback(
                                            //           (timeStamp) {
                                            //     Provider.of<TotalAmountProvider>(
                                            //             context,
                                            //             listen: false)
                                            //         .setAmount(totalAmount);
                                            //   });
                                            // }
                                            return CardWidget(
                                              productModel: productModel,
                                              itemQunter:
                                                  productQuantityListFromCartList![
                                                      itemIndex],
                                              index: itemIndex + 1,
                                            );
                                          },
                                        );
                                      }
                                      return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 3,
                                          itemBuilder: (context, itemIndex) {
                                            return const LoadingCardWidget();
                                          });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .35,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: utils.bottomTotalBill,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Consumer<TotalAmountProvider>(
                      builder: (context, value, child) {
                        totalAmount += value.getAmount;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount",
                                    style: Textstyle.mediumText600.copyWith(
                                        color: Theme.of(context).hintColor)),
                                Text(
                                  "Tk ${value.getAmount.toString()}",
                                  style: Textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Charge",
                                    style: Textstyle.mediumText600.copyWith(
                                        color: Theme.of(context).hintColor)),
                                Text(
                                  deliveryAmount.toString(),
                                  style: Textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Carry Bag Charge",
                                  style: Textstyle.mediumText600.copyWith(
                                      color: Theme.of(context).hintColor),
                                ),
                                Text(
                                  "0.00",
                                  style: Textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Adjust the width as needed
                              child: CustomPaint(
                                painter: DottedLinePainter(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: Textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                                ),
                                Text(
                                  "${value.getAmount + deliveryAmount}",
                                  style: Textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BillPage(),
                                    ));
                              },
                              child: Container(
                                height: 60,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color:AppColors. greenColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "Continue",
                                  style: Textstyle.mediumTextbold
                                      .copyWith(color:AppColors. white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
*/
