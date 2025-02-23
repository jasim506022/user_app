import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_function.dart';
import '../../../res/app_colors.dart';
import '../../../model/products_model.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/cart_funtion.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/product_image_widget.dart';
import '../../../res/network_utili.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Container(
          height: 130.h,
          width: .83.sw,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black,
                  spreadRadius: .05,
                )
              ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImageWidget(
                productModel: productModel,
                height: 110.h,
                width: 110.h,
                imageHeith: 110.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 12.w, top: 15.h, bottom: 15.h),
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "৳. ${AppsFunction.calculateDiscountedPrice(productModel.productprice!, productModel.discount!.toDouble())}",
              style: AppsTextStyle.bodyTextStyle.copyWith(color: AppColors.red),
            ),
            AppsFunction.horizontalSpacing(15),
            Text(
              productModel.productprice!.toString(),
              style: AppsTextStyle.mediumText400lineThrough,
            ),
          ],
        ),
        AppsFunction.verticalSpacing(5),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: productModel.productname!,
              style: AppsTextStyle.bodyTextStyle,
            ),
            TextSpan(
              text: productModel.productunit!,
              style: AppsTextStyle.smallBoldText,
            ),
          ]),
        ),
        AppsFunction.verticalSpacing(5),
        Container(
          alignment: Alignment.center,
          height: 35.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: isCart ? AppColors.red : AppColors.accentGreen,
          ),
          child: Text(
            AppString.addToCart,
            style: AppsTextStyle.buttonTextStyle,
          ),
        ),
      ],
    );
  }
}
