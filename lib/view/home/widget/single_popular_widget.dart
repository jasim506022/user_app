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

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({
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
              "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
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
        AppsFunction.verticleSpace(5),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: productModel.productname!,
              style: AppsTextStyle.boldBodyTextStyle,
            ),
            TextSpan(
              text: productModel.productunit!,
              style: AppsTextStyle.smallBoldText,
            ),
          ]),
        ),
        AppsFunction.verticleSpace(5),
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
