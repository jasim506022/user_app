import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/routes_name.dart';
import '../res/app_function.dart';
import '../res/apps_text_style.dart';
import '../res/cart_funtion.dart';

import '../../res/app_colors.dart';

import '../model/productsmodel.dart';
import '../view/home/widget/product_discount_widget.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    bool isCart =
        CartFunctions.separateProductID().contains(productModel.productId);

    return InkWell(
      onTap: () async {
        if (!(await AppsFunction.verifyInternetStatus())) {
          Get.toNamed(RoutesName.productDestailsPage, arguments: productModel);
        }
      },
      child: Card(
        child: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.white,
                  spreadRadius: .08,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(productModel),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: _buildProductDetails(productModel, isCart),
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
          height: 2.h,
        ),
        FittedBox(
          child: Text(
            productModel.productname!,
            style: AppsTextStyle.boldBodyTextStyle,
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
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
                color: isCart ? AppColors.red : AppColors.greenColor,
              ),
              child: Text(
                "Add To Cart",
                style: AppsTextStyle.buttonTextStyle,
              ),
            )),
        SizedBox(
          height: 7.h,
        ),
      ],
    );
  }

  Stack _buildProductImage(ProductModel productModel) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          alignment: Alignment.center,
          margin: EdgeInsets.all(10.r),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
              color: AppColors.cardImageBg,
              borderRadius: BorderRadius.circular(5.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: FancyShimmerImage(
              height: 90.h,
              boxFit: BoxFit.contain,
              imageUrl: productModel.productimage![0],
            ),
          ),
        ),
        ProductDiscountWidget(discount: productModel.discount!)
      ],
    );
  }
}
