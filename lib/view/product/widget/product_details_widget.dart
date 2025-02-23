import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/product_controller.dart';
import '../../../model/products_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel.productname!,
            style: AppsTextStyle.largeBoldText.copyWith(fontSize: 20.sp)),
        AppsFunction.verticalSpacing(10),
        _buildPriceRow(),
        AppsFunction.verticalSpacing(15),
        Text(productModel.productdescription!,
            textAlign: TextAlign.justify,
            style: AppsTextStyle.mediumNormalText),
        AppsFunction.verticalSpacing(20),
        _buildQuantityAndRatingRow(productController, context),
        AppsFunction.verticalSpacing(15),
      ],
    );
  }

  Row _buildQuantityAndRatingRow(
      ProductController productController, BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Text(
              "${AppString.currencyIcon} ${AppsFunction.calculateTotalPrice(productModel.productprice!, productModel.discount!.toDouble(), productController.productItemQuantity.value).toStringAsFixed(2)}",
              style: AppsTextStyle.largeBoldRedText
                  .copyWith(color: AppColors.accentGreen)),
        ),
        AppsFunction.horizontalSpacing(20),
        Row(
          children: [
            _buildIncreandDecrementButton(() {
              productController.updateQuantity();
            }, Icons.add),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Obx(() => Text(
                  productController.productItemQuantity.value.toString(),
                  style: AppsTextStyle.largestText)),
            ),
            _buildIncreandDecrementButton(
              () {
                productController.updateQuantity(isIncrement: false);
              },
              Icons.remove,
            ),
          ],
        ),
        const Spacer(),
        Row(
          children: [
            Icon(Icons.star, color: AppColors.brightYellow),
            RichText(
              text: TextSpan(
                  style: AppsTextStyle.rattingText.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  children: [
                    const TextSpan(text: "( "),
                    TextSpan(text: productModel.productrating!.toString()),
                    TextSpan(
                        text: " ${AppString.rattings} ",
                        style: AppsTextStyle.rattingText),
                    TextSpan(
                        text: ")",
                        style: AppsTextStyle.rattingText.copyWith(
                          color: Theme.of(context).primaryColor,
                        )),
                  ]),
            ),
          ],
        ),
      ],
    );
  }

  Row _buildPriceRow() {
    return Row(
      children: [
        Text(
            "${AppString.currencyIcon} ${AppsFunction.calculateDiscountedPrice(productModel.productprice!, productModel.discount!.toDouble())}",
            style: AppsTextStyle.largeBoldRedText),
        AppsFunction.horizontalSpacing(10),
        Text(productModel.productunit!, style: AppsTextStyle.smallBoldText),
        AppsFunction.horizontalSpacing(50),
        Text(
          "${AppString.discount}: ${(productModel.discount!)}${AppString.percentIcon}",
          style: AppsTextStyle.largeBoldRedText,
        ),
        AppsFunction.horizontalSpacing(12),
        Text(
          productModel.productprice.toString(),
          style: AppsTextStyle.largeBoldRedText
              .copyWith(decoration: TextDecoration.lineThrough),
        ),
      ],
    );
  }

  Widget _buildIncreandDecrementButton(
    VoidCallback function,
    IconData icon,
  ) {
    return Obx(() {
      final isInCart = Get.find<ProductController>().isProductInCart.value;

      return InkWell(
        onTap: isInCart
            ? () {
                AppsFunction.flutterToast(msg: AppString.alreadyAdded);
              }
            : function,
        child: Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
              color: isInCart ? AppColors.red : AppColors.accentGreen,
              borderRadius: BorderRadius.circular(10.r)),
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      );
    });
  }
}
