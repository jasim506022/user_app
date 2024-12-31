import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/product_controller.dart';
import '../../../model/products_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/cart_funtion.dart';
import '../../../res/constant/string_constant.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    // _initializeProductData();
    var productController = Get.find<ProductController>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel.productname!,
            style: AppsTextStyle.largeBoldText.copyWith(fontSize: 20.sp)),
        AppsFunction.verticleSpace(10),
        _buildPriceRow(),
        AppsFunction.verticleSpace(15),
        Text(productModel.productdescription!,
            textAlign: TextAlign.justify,
            style: AppsTextStyle.mediumNormalText),
        AppsFunction.verticleSpace(20),
        _buildQuantityAndRatingRow(productController, context),
        AppsFunction.verticleSpace(15),
      ],
    );
  }

/*
  void _initializeProductData() {
    var productController = Get.find<ProductController>();

    if (!productController.isProductInCart.value) {
      productController.resetQuantity();
    } else {
      try {
        Future.microtask(() {
          productController.productItemQuantity.value =
              CartFunctions.productQuantiyList(productModel.productId!);
        });
      } catch (e) {
        productController.productItemQuantity.value =
            0; // Default value in case of error
        print("Error fetching product quantity: $e");
      }
    }
  }
*/

  // void _initializeProductData() {
  //   // productController.verifyProductInCart(productId: productModel.productId!);
  //   var productController = Get.find<ProductController>();
  //   if (!productController.isProductInCart.value) {
  //     productController.resetQuantity();
  //   } else {
  //     Future.microtask(() {
  //       productController.productItemQuantity.value =
  //           CartFunctions.productQuantiyList(productModel.productId!);
  //     });
  //   }
  //   // productController.verifyProductInCart(productId: productModel.productId!);
  // }

  Row _buildQuantityAndRatingRow(
      ProductController productController, BuildContext context) {
    return Row(
      children: [
        Obx(
          () => Text(
              "${AppString.currencyIcon} ${AppsFunction.productPriceWithQuantity(productModel.productprice!, productModel.discount!.toDouble(), productController.productItemQuantity.value).toStringAsFixed(2)}",
              style: AppsTextStyle.largeBoldRedText
                  .copyWith(color: AppColors.accentGreen)),
        ),
        AppsFunction.horizontalSpace(20),

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

            //Increament Button
            _buildIncreandDecrementButton(
              () {
                productController.updateQuantity(isIncrement: false);
              },
              Icons.remove,
            ),
          ],
        ),

        const Spacer(),
        // Rattting Product
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
                        text: " ${StringConstant.rattings} ",
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
            "${AppString.currencyIcon} ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
            style: AppsTextStyle.largeBoldRedText),
        AppsFunction.horizontalSpace(10),
        Text(productModel.productunit!, style: AppsTextStyle.smallBoldText),
        AppsFunction.horizontalSpace(50),
        Text(
          "${AppString.discount}: ${(productModel.discount!)}${AppString.percentIcon}",
          style: AppsTextStyle.largeBoldRedText,
        ),
        AppsFunction.horizontalSpace(12),
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
                AppsFunction.flutterToast(msg: StringConstant.alreadyAdded);
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
