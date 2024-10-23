import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../res/app_colors.dart';
import '../../res/appasset/image_asset.dart';

import '../../res/apps_text_style.dart';
import '../../widget/empty_widget.dart';

import 'widget/cart_summary_widget.dart';
import 'widget/productg_list_by_seller_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Bangladesh");
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));

    var cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Cart Item")),
      body: Obx(() {
        cartController.resetTotalAmount();

        if (cartController.cartItemCount.value == 1 ||
            cartController.cartItemCount.value == 0) {
          return _buildEmptyCartView();
        } else {
          return Column(
            children: [
              SizedBox(
                height: 0.6.sh,
                child: StreamBuilder(
                  stream: cartController.cartSellerSnapshot(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty) {
                      return _buildEmptyCartView();
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
                              ProductListBySellerWidget(sellerId: sellerId),
                            ],
                          );
                        },
                      );
                    }

                    return const CircularProgressIndicator();
                  },
                ),
              ),
              const Expanded(child: CartSummaryWidget())
            ],
          );
        }
      }),
    );
  }

  Widget _buildEmptyCartView() {
    return EmptyWidget(
      image: ImagesAsset.error,
      title: "No Cart Available",
    );
  }

  Padding _buildSellerName(sellerName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: RichText(
          text: TextSpan(style: AppsTextStyle.largestText, children: [
        const TextSpan(text: "Seller Name:\t"),
        TextSpan(
          text: sellerName,
          style: AppsTextStyle.largestText.copyWith(color: AppColors.red),
        )
      ])),
    );
  }
}
