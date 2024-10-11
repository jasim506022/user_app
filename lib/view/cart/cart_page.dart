import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../controller/cart_controller.dart';
import '../../res/appasset/image_asset.dart';
import '../../res/cart_funtion.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../model/productsmodel.dart';
import '../../res/routes/routes_name.dart';
import '../../res/utils.dart';

import '../../widget/empty_widget.dart';
import 'cart_widget.dart';
import 'dot_line_printer.dart';
import 'loading_card_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Cart Item")),
      body: Obx(() {
        cartController.setSzeo();
        if (cartController.shareP.value == 1) {
          return EmptyWidget(
            image: ImagesAsset.error,
            title: "No Cart Avaiable",
          );
        } else {
          return Column(
            children: [
              SizedBox(
                height: 0.6.sh,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: cartController.cartSellerSnapshot(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return EmptyWidget(
                        image: ImagesAsset.error,
                        title: 'No User Available',
                      );
                    } else if (snapshot.hasError) {
                      return EmptyWidget(
                        image: ImagesAsset.error,
                        title: 'Error Occure: ${snapshot.error}',
                      );
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var sellerName = snapshot.data!.docs[index]["name"];
                          var sellerId = snapshot.data!.docs[index]["uid"];

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSellerName(sellerName),
                              _buildProductListBySeller(sellerId),
                            ],
                          );
                        },
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
              Expanded(child: _buildBottom(utils, context))
            ],
          );
        }
      }),
    );
  }

  Flexible _buildProductListBySeller(String sellerId) {
    return Flexible(
      child: StreamBuilder(
        stream: cartController.cartproductSnapshot(sellerId: sellerId),
        builder: (context, productSnashot) {
          if (productSnashot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, itemIndex) {
                  return const LoadingCardWidget();
                });
          } else if (productSnashot.hasData) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productSnashot.data!.docs.length,
              itemBuilder: (context, itemIndex) {
                ProductModel productModel = ProductModel.fromMap(
                    productSnashot.data!.docs[itemIndex].data());

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  cartController.setAmount(productModel, itemIndex);
                });
                int cartIndex = _getCartIndex(productModel.productId);

                return CardWidget(
                  productModel: productModel,
                  itemQunter:
                      CartFunctions.seperateProductQuantiyList()[cartIndex],
                  index: itemIndex + 1,
                );
              },
            );
          }
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, itemIndex) {
                return const LoadingCardWidget();
              });
        },
      ),
    );
  }

  int _getCartIndex(String? productId) {
    final productIDs = CartFunctions.separateProductID();
    return productIDs.indexOf(productId ?? '');
  }

  Padding _buildSellerName(sellerName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: RichText(
          text: TextSpan(style: Textstyle.largestText, children: [
        const TextSpan(text: "Seller Name:\t"),
        TextSpan(
          text: sellerName,
          style: Textstyle.largestText.copyWith(color: AppColors.red),
        )
      ])),
    );
  }

  Container _buildBottom(Utils utils, BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: utils.bottomTotalBill,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.r),
          topRight: Radius.circular(60.r),
        ),
      ),
      child: Obx(() {
        final totalAmount = cartController.totalAmount.value;
        final subTotal = totalAmount + 50; // Fixed delivery amount

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 14.h),
            _buildAmountRow("Total Amount", totalAmount.toStringAsFixed(2)),
            _buildAmountRow("Delivery Charge", "50.00"),
            _buildAmountRow("Carry Bag Charge", "0.00"),
            SizedBox(height: 8.h),
            SizedBox(
              width: 1.sw,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
            SizedBox(height: 8.h),
            _buildAmountRow("Sub Total (BDT)", subTotal.toStringAsFixed(2),
                isBold: true),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                Get.toNamed(RoutesName.billPage);
              },
              child: Container(
                height: 40.h,
                alignment: Alignment.center,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: AppColors.greenColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Text(
                  "Continue",
                  style:
                      Textstyle.mediumTextbold.copyWith(color: AppColors.white),
                ),
              ),
            ),
            SizedBox(height: 5.h),
          ],
        );
      }),
    );
  }

  Row _buildAmountRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: isBold
                ? Textstyle.mediumTextbold
                    .copyWith(color: Theme.of(context).primaryColor)
                : Textstyle.mediumText600
                    .copyWith(color: Theme.of(context).hintColor)),
        Text(
          amount,
          style: Textstyle.mediumTextbold
              .copyWith(color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
