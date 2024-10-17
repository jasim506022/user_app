import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';
import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import '../../res/constant/string_constant.dart';
import '../../res/routes/routes_name.dart';
import '../../res/app_colors.dart';

import '../../res/utils.dart';

import '../../model/productsmodel.dart';

import 'widget/add_cart_item_float_widget.dart';
import 'widget/details_page_image_slide_with_cart_bridge_widget.dart';
import 'widget/similar_product_list.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    ProductModel productModel = Get.arguments;

    _setStatusBarStle(context);

    productController.resetCounter();
    productController.checkIsCart(productId: productModel.productId!);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) Get.offAndToNamed(RoutesName.mainPage);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: AddCartItemFloatWidget(
          productModel: productModel,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              DetailsPageImageSlideWithCartBridgeWidget(
                  productModel: productModel),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductAllDetails(
                        context, productModel, productController),
                    Text(
                      StringConstant.similarProducts,
                      style: AppsTextStyle.largeBoldText.copyWith(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SimilarProductList(productModel: productModel),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setStatusBarStle(BuildContext context) {
    Utils utils = Utils(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
  }

  Column _buildProductAllDetails(BuildContext context,
      ProductModel productModel, ProductController productController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel.productname!,
            style: AppsTextStyle.titleTextStyle.copyWith(fontSize: 20.sp)),
        SizedBox(
          height: 15.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                style: AppsTextStyle.largeProductFontStyle),
            SizedBox(
              width: 10.w,
            ),
            Text("${productModel.productunit}", style: AppsTextStyle.smallText),
            SizedBox(
              width: 50.h,
            ),
            Text(
              "Discount: ${(productModel.discount!)}%",
              style: AppsTextStyle.largeProductFontStyle,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              "${(productModel.productprice!)}",
              style: AppsTextStyle.largeProductFontStyle.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(productModel.productdescription!,
            textAlign: TextAlign.justify, style: AppsTextStyle.bodyTextStyle),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            Obx(
              () => Text(
                  "৳. ${AppsFunction.productPriceWithQuantity(productModel.productprice!, productModel.discount!.toDouble(), productController.productItemQuantity.value).toStringAsFixed(2)}",
                  style: AppsTextStyle.largeProductFontStyle
                      .copyWith(color: AppColors.greenColor)),
            ),
            SizedBox(
              width: 20.w,
            ),

            Row(
              children: [
                _buildIncreandDecrementButton(() {
                  productController.incrementOrDecrement();
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
                    productController.incrementOrDecrement(isIncrement: false);
                  },
                  Icons.remove,
                ),
              ],
            ),

            const Spacer(),
            // Rattting Product
            Row(
              children: [
                Icon(Icons.star, color: AppColors.yellow),
                RichText(
                  text: TextSpan(
                      style: AppsTextStyle.rattingText.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                      children: [
                        const TextSpan(text: "( "),
                        TextSpan(text: "${productModel.productrating!}"),
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
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

// Increment and Decrement Buttton
  Widget _buildIncreandDecrementButton(
    VoidCallback function,
    IconData icon,
  ) {
    var productController = Get.find<ProductController>();
    return Obx(
      () => InkWell(
        onTap: productController.isInCart.value
            ? () {
                AppsFunction.flutterToast(msg: StringConstant.alreadyAdded);
              }
            : function,
        child: Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
              color: productController.isInCart.value
                  ? AppColors.red
                  : AppColors.greenColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  // Floating action button for adding item to cart
}
