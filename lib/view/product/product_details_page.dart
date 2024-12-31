import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/product_controller.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../res/cart_funtion.dart';
import '../../res/constant/string_constant.dart';
import '../../res/routes/routes_name.dart';

import '../../res/utils.dart';

import '../../model/products_model.dart';

import 'widget/add_cart_item_float_widget.dart';
import 'widget/details_page_image_slide_with_cart_bridge_widget.dart';
import 'widget/product_details_widget.dart';
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
    productModel = arguments[AppString.productModel];

    isBackCart = arguments[AppString.isCartBack] ?? false;

    _initializeProductData();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  void _initializeProductData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.verifyProductInCart(productId: productModel.productId!);

      if (productController.isProductInCart.value == false) {
        productController.resetQuantity();
      } else {
        productController.productItemQuantity.value =
            CartFunctions.productQuantiyList(productModel.productId!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          isBackCart! ? Get.back() : Get.offAndToNamed(RoutesName.mainPage);
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
              AppsFunction.verticleSpace(20),
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
                    ProductDetailsWidget(
                      productModel: productModel,
                    ),
                    Text(
                      StringConstant.similarProducts,
                      style:
                          AppsTextStyle.largeBoldText.copyWith(fontSize: 18.sp),
                    ),
                    AppsFunction.verticleSpace(10),
                    SimilarProductList(
                      productModel: productModel,
                      isCart: productController.isProductInCart.value,
                    ),
                    AppsFunction.verticleSpace(20),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
