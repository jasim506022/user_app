import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../res/app_function.dart';
import '../../../res/app_colors.dart';
import '../../../model/productsmodel.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/cart_funtion.dart';
import '../../../res/constant/string_constant.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/product_image_widget.dart';
import 'product_discount_widget.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    bool isInCart =
        CartFunctions.separateProductID().contains(productModel.productId);

    return InkWell(
      onTap: () async {
        if (!(await AppsFunction.verifyInternetStatus())) {
          Get.toNamed(RoutesName.productDestailsPage,
              arguments: {"productModel": productModel, "isCart": false});
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Container(
          height: 120.h,
          width: .8.sw,
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
              _buildProductImage(productModel),
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
            SizedBox(
              width: 15.w,
            ),
            Text(
              "${(productModel.productprice!)}",
              style: AppsTextStyle.mediumText400lineThrough,
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: productModel.productname!,
              style: AppsTextStyle.boldBodyTextStyle,
            ),
            TextSpan(
              text: "(${productModel.productunit!})",
              style: AppsTextStyle.smallText,
            ),
          ]),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          alignment: Alignment.center,
          height: 35.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            color: isCart ? AppColors.red : AppColors.greenColor,
          ),
          child: Text(
            StringConstant.addToCart,
            style: AppsTextStyle.buttonTextStyle,
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage(ProductModel productModel) {
    return ProductImageWidget(
      productModel: productModel,
      height: 110.h,
      width: 110.h,
      imageHeith: 110.h,
    );
  }
}

