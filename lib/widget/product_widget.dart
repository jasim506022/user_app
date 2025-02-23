import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';
import 'package:user_app/res/routes/routes_name.dart';
import '../res/app_function.dart';
import '../res/apps_text_style.dart';
import '../res/cart_funtion.dart';

import '../../res/app_colors.dart';

import '../model/products_model.dart';

import '../res/network_utili.dart';
import 'product_image_widget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    bool isInCart =
        CartManager.getProductIds().contains(productModel.productId);

    return InkWell(
      onTap: () async {
        NetworkUtils.executeWithInternetCheck(action: () {
          Get.toNamed(AppRoutesName.productDetailsPage, arguments: {
            AppString.productModel: productModel,
            AppString.isCartBack: false
          });
        });

/*
        if (!(await NetworkUtili.verifyInternetStatus())) {
          Get.toNamed(AppRoutesName.productDetailsPage, arguments: {
            AppString.productModel: productModel,
            AppString.isCartBack: false
          });
        }

*/
      },
      child: Card(
        color: Theme.of(context).cardColor,
        child: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor,
                  spreadRadius: .08,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageWidget(
                imageHeith: 90.h,
                productModel: productModel,
                height: 100.h,
                width: 1.sw,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: _buildProductDetails(productModel, isInCart),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _buildProductDetails(ProductModel productModel, bool isCart) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "${AppString.currencyIcon} ${AppsFunction.calculateDiscountedPrice(productModel.productprice!, productModel.discount!.toDouble())}",
              style: AppsTextStyle.bodyTextStyle.copyWith(color: AppColors.red),
            ),
            AppsFunction.horizontalSpacing(15),
            Text(
              productModel.productprice!.toString(),
              style: AppsTextStyle.mediumText400lineThrough,
            ),
          ],
        ),
        AppsFunction.verticalSpacing(2),
        Text(
          productModel.productname ?? "Bangladesh",
          style: AppsTextStyle.bodyTextStyle,
        ),
        AppsFunction.verticalSpacing(5),
        InkWell(
            onTap: () async {
              NetworkUtils.executeWithInternetCheck(action: () {
                Get.toNamed(AppRoutesName.productDetailsPage,
                    arguments: productModel);
              });

/*
              if (!(await NetworkUtili.verifyInternetStatus())) {
                Get.toNamed(AppRoutesName.productDetailsPage,
                    arguments: productModel);
              }
*/
            },
            child: Container(
              alignment: Alignment.center,
              height: 45.h,
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: isCart ? AppColors.red : AppColors.accentGreen,
              ),
              child: Text(
                AppString.addToCart,
                style: AppsTextStyle.buttonTextStyle,
              ),
            )),
        AppsFunction.verticalSpacing(7)
      ],
    );
  }
}
