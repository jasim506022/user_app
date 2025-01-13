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
        CartFunctions.separateProductID().contains(productModel.productId);

    return InkWell(
      onTap: () async {
        if (!(await AppsFunction.verifyInternetStatus())) {
          Get.toNamed(RoutesName.productDestailsPage, arguments: {
            AppString.productModel: productModel,
            AppString.isCartBack: false
          });
        }
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
              "${AppString.currencyIcon} ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
              style: AppsTextStyle.boldBodyTextStyle
                  .copyWith(color: AppColors.red),
            ),
            AppsFunction.horizontalSpace(15),
            Text(
              productModel.productprice!.toString(),
              style: AppsTextStyle.mediumText400lineThrough,
            ),
          ],
        ),
        AppsFunction.verticleSpace(2),
        Text(
          productModel.productname ?? "Bangladesh",
          style: AppsTextStyle.boldBodyTextStyle,
        ),
        AppsFunction.verticleSpace(5),
        InkWell(
            onTap: () async {
              if (!(await AppsFunction.verifyInternetStatus())) {
                Get.toNamed(RoutesName.productDestailsPage,
                    arguments: productModel);
              }
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
        AppsFunction.verticleSpace(7)
      ],
    );
  }
}
