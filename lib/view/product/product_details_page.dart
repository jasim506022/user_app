import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/cart_funtion.dart';

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

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  var productController = Get.find<ProductController>();
  late ProductModel productModel;

  bool? isBackCart;

  @override
  void initState() {
    var arguments = Get.arguments;
    productModel = arguments["productModel"];
    productController.verifyProductInCart(productId: productModel.productId!);

    isBackCart = arguments["isCartBack"] ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!productController.isProductInCart.value) {
        productController.resetQuantity();
      } else {
        productController.productItemQuantity.value =
            CartFunctions.productQuantiyList(productModel.productId!);
      }
      productController.verifyProductInCart(productId: productModel.productId!);
    });
    productController.verifyProductInCart(productId: productModel.productId!);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Utils utils = Utils();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          isBackCart!
              ? Get.toNamed(RoutesName.cartPage)
              : Get.offAndToNamed(RoutesName.mainPage);
        }
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
                productModel: productModel,
                backCart: isBackCart!,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductAllDetails(productModel, productController),
                    Text(
                      StringConstant.similarProducts,
                      style:
                          AppsTextStyle.largeBoldText.copyWith(fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SimilarProductList(
                      productModel: productModel,
                      isCart: productController.isProductInCart.value,
                    ),
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

  Column _buildProductAllDetails(
      ProductModel productModel, ProductController productController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel.productname!,
            style: AppsTextStyle.largeBoldText.copyWith(fontSize: 20.sp)),
        SizedBox(
          height: 15.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                style: AppsTextStyle.largeBoldRedText),
            SizedBox(
              width: 10.w,
            ),
            Text("${productModel.productunit}",
                style: AppsTextStyle.smallBoldText),
            SizedBox(
              width: 50.h,
            ),
            Text(
              "Discount: ${(productModel.discount!)}%",
              style: AppsTextStyle.largeBoldRedText,
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              "${(productModel.productprice!)}",
              style: AppsTextStyle.largeBoldRedText
                  .copyWith(decoration: TextDecoration.lineThrough),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(productModel.productdescription!,
            textAlign: TextAlign.justify,
            style: AppsTextStyle.mediumNormalText),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            Obx(
              () => Text(
                  "৳. ${AppsFunction.productPriceWithQuantity(productModel.productprice!, productModel.discount!.toDouble(), productController.productItemQuantity.value).toStringAsFixed(2)}",
                  style: AppsTextStyle.largeBoldRedText
                      .copyWith(color: AppColors.greenColor)),
            ),
            SizedBox(
              width: 20.w,
            ),

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
        onTap: productController.isProductInCart.value
            ? () {
                AppsFunction.flutterToast(msg: StringConstant.alreadyAdded);
              }
            : function,
        child: Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
              color: productController.isProductInCart.value
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
}
