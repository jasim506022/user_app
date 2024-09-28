import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/controller/product_controller.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/view/product/widget/similar_product_list.dart';
import '../../res/routes/routesname.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../res/utils.dart';

import '../../model/productsmodel.dart';

import 'widget/details_page_image_slide_with_cart_bridge_widget.dart';

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
        floatingActionButton: _buildAddCartItemFlotatActionButton(
            productModel, productController),
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
                      "Similar Products",
                      style: GoogleFonts.abrilFatface(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.sp,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    // _buildSimilarProjectList(),
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

  Column _buildProductAllDetails(BuildContext context,
      ProductModel productModel, ProductController productController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel.productname!,
            style: Textstyle.largestText.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 20.sp,
              letterSpacing: 1.2,
            )),
        SizedBox(
          height: 15.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
              style: GoogleFonts.abrilFatface(
                  color: AppColors.greenColor,
                  fontSize: 16.sp,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "${productModel.productunit}",
              style: GoogleFonts.abrilFatface(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.sp,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 50.h,
            ),
            Text(
              "Discount: ${(productModel.discount!)}%",
              style: GoogleFonts.poppins(
                  color: AppColors.red,
                  letterSpacing: 1.2,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              "${(productModel.productprice!)}",
              style: GoogleFonts.poppins(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.red,
                  letterSpacing: 1.2,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
          productModel.productdescription!,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(
              color: Theme.of(context).primaryColor,
              fontSize: 12.sp,
              letterSpacing: 1.2,
              fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          children: [
            Obx(
              () => Text(
                "৳. ${AppsFunction.productPriceWithQuantity(productModel.productprice!, productModel.discount!.toDouble(), productController.counter.value).toStringAsFixed(2)}",
                style: Textstyle.largeText.copyWith(
                  color: AppColors.greenColor,
                  letterSpacing: 1.2,
                ),
              ),
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
                      productController.counter.value.toString(),
                      style: Textstyle.largestText)),
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
                      style: Textstyle.mediumText600.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                      children: [
                        const TextSpan(text: "( "),
                        TextSpan(text: "${productModel.productrating!}"),
                        TextSpan(
                          text: " Rattings ",
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                          ),
                        ),
                        const TextSpan(text: ")"),
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
        onTap: productController.isCart.value
            ? () {
                AppsFunction.flutterToast(msg: "Already Added");
              }
            : function,
        child: Container(
          padding: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
              color: productController.isCart.value
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
  Widget _buildAddCartItemFlotatActionButton(
      ProductModel productModel, ProductController productController) {
    return Obx(
      () => FloatingActionButton.extended(
        backgroundColor: productController.isCart.value
            ? AppColors.red
            : AppColors.greenColor,
        onPressed: productController.isCart.value
            ? () => AppsFunction.flutterToast(msg: "Item is already in cart")
            : () => productController.addItemToCart(
                  productId: productModel.productId!,
                  sellerId: productModel.sellerId!,
                ),
        icon: Icon(
          Icons.shopping_cart,
          color: AppColors.white,
        ),
        label: Text(
          productController.isCart.value
              ? "Item Already in Cart"
              : "Add To Cart",
          style: Textstyle.smallText.copyWith(color: AppColors.white),
        ),
      ),
    );
  }

  void _setStatusBarStle(BuildContext context) {
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/controller/product_controller.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/view/product/similar_product_list.dart';
import '../../res/routes/routesname.dart';
import '../../res/cart_funtion.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../res/utils.dart';

import '../../model/productsmodel.dart';

import 'details_page_image_slide_with_cart_bridge_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  // ProductModel? productModel;

  // bool isCart = false;

  // int counter = 1;

  // List<String> productIdListFromCartLish = CartFunctions.separateProductID();

  var productController = Get.find<ProductController>();

  @override
  void initState() {
    // if (productIdListFromCartLish.contains(productModel!.productId)) {
    //   isCart = true;
    // }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ProductModel productModel = Get.arguments;
    productController.resetCounter();
    productController.checkIsCart(productId: productModel.productId!);
    // bool isCart =
    //     CartFunctions.separateProductID().contains(productModel!.productId);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          Get.offAndToNamed(RoutesName.mainPage);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: _buildAddCartItemFlotatActionButton(productModel),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              DetailsPageImageSlideWithCartBridgeWidget(
                  productController: productController,
                  productModel: productModel),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductDetails(context, productModel),

                    Text(
                      "Similar Products",
                      style: GoogleFonts.abrilFatface(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // _buildSimilarProjectList(),
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

  Column _buildProductDetails(
    BuildContext context,
    ProductModel productModel,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(productModel!.productname!,
            style: Textstyle.largestText.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              letterSpacing: 1.2,
            )),
        const SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "৳. ${AppsFunction.productPrice(productModel!.productprice!, productModel!.discount!.toDouble())}",
              style: GoogleFonts.abrilFatface(
                  color: AppColors.greenColor,
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${productModel!.productunit}",
              style: GoogleFonts.abrilFatface(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 50,
            ),
            Text(
              "Discount: ${(productModel!.discount!)}%",
              style: GoogleFonts.poppins(
                  color: AppColors.red,
                  letterSpacing: 1.2,
                  fontSize: 16,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              width: 12,
            ),
            Text(
              "${(productModel!.productprice!)}",
              style: GoogleFonts.poppins(
                  decoration: TextDecoration.lineThrough,
                  color: AppColors.red,
                  letterSpacing: 1.2,
                  fontSize: 18,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          productModel!.productdescription!,
          textAlign: TextAlign.justify,
          style: GoogleFonts.poppins(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Obx(
              () => Text(
                "৳. ${AppsFunction.productPriceWithQuantity(productModel!.productprice!, productModel!.discount!.toDouble(), productController.counter.value).toStringAsFixed(2)}",
                style: Textstyle.largeText.copyWith(
                  color: AppColors.greenColor,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),

            Row(
              children: [
                //Increament Button
                _buildIncreandDecrementButton(() {
                  productController.incrementandDecrement();
                  // counter++;
                  // setState(() {});
                }, Icons.add),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Obx(() => Text(
                      productController.counter.value.toString(),
                      style: Textstyle.largestText)),
                ),

                //Increament Button
                _buildIncreandDecrementButton(
                  () {
                    // if (counter == 1) {
                    //   AppsFunction.flutterToast(
                    //       msg: "The Quantity cannot be less then 1");
                    // } else {
                    //   counter--;
                    //   setState(() {});
                    // }
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
                      style: Textstyle.mediumText600.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      children: [
                        const TextSpan(text: "( "),
                        TextSpan(text: "${productModel!.productrating!}"),
                        TextSpan(
                          text: " Rattings ",
                          style: GoogleFonts.poppins(
                            color: Theme.of(context).hintColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const TextSpan(text: ")"),
                      ]),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

// Increment and Decrement Buttton
  InkWell _buildIncreandDecrementButton(
    VoidCallback function,
    IconData icon,
  ) {
    return InkWell(
      onTap: productController.isCart.value
          ? () {
              AppsFunction.flutterToast(msg: "Already Added");
            }
          : function,
      child: Obx(
        () => Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: productController.isCart.value
                  ? AppColors.red
                  : AppColors.greenColor,
              borderRadius: BorderRadius.circular(10)),
          child: Icon(
            icon,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  // Add item on cart function
  Widget _buildAddCartItemFlotatActionButton(ProductModel productModel) {
    //extended us for icon and text
    return Obx(
      () => FloatingActionButton.extended(
        backgroundColor: productController.isCart.value
            ? AppColors.red
            : AppColors.greenColor,
        onPressed: productController.isCart.value
            ? () {
                AppsFunction.flutterToast(msg: "Item is already  in cart");
              }
            : () {
                List<String> cartItemIdList = CartFunctions.separateProductID();

                if (cartItemIdList.contains(productModel!.productId)) {
                  AppsFunction.flutterToast(msg: "Item is already  in cart");
                } else {
                  CartFunctions.addItemToCartWithSeller(
                      productId: productModel!.productId!,
                      productCounter: productController.counter.value,
                      seller: productModel!.sellerId!,
                      context: context);
                  productController.isCart.value = true;
                  // setState(() {});
                }
              },
        icon: Icon(
          Icons.shopping_cart,
          color: AppColors.white,
        ),
        label: Text(
          productController.isCart.value
              ? "Item Already in Cart"
              : "Add To Cart",
          style: Textstyle.smallText.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}

*/