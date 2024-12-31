import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../res/app_colors.dart';
import '../../res/app_asset/image_asset.dart';

import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../widget/empty_widget.dart';

import 'widget/cart_summary_widget.dart';
import 'widget/productg_list_by_seller_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    // Configure system UI overlay style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));

    return Scaffold(
        appBar: AppBar(title: const Text(AppString.cart)),
        body: Obx(() {
          cartController.resetTotalAmount();
          return cartController.cartItemCounter.value == 0
              ? _buildEmptyCartView()
              : Column(
                  children: [
                    SizedBox(
                      height: 0.6.sh,
                      child: SingleChildScrollView(
                        child: _buildSellerList(cartController),
                      ),
                    ),
                    const Expanded(child: CartSummaryWidget())
                  ],
                );
        }));
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _buildSellerList(
      CartController cartController) {
    return StreamBuilder(
      stream: cartController.fetchSellersForCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return _buildEmptyCartView();
        }
        if (snapshot.hasError) {
          return EmptyWidget(
            image: ImagesAsset.error,
            title: '${AppString.errorOccure} ${snapshot.error}',
          );
        }
        if (snapshot.hasData) {
          final docs = snapshot.data?.docs;
          if (docs == null || docs.isEmpty) {
            return _buildEmptyCartView();
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var sellerName = docs[index]["name"];
              var sellerId = docs[index]["uid"];

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
    );
  }

  Widget _buildEmptyCartView() {
    return EmptyWidget(
      image: ImagesAsset.error,
      title: AppString.noCartAvailabe,
    );
  }

  Padding _buildSellerName(sellerName) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: RichText(
          text: TextSpan(style: AppsTextStyle.largestText, children: [
        const TextSpan(text: "${AppString.sellerName}:\t"),
        TextSpan(
          text: sellerName,
          style: AppsTextStyle.largestText.copyWith(color: AppColors.red),
        )
      ])),
    );
  }
}
