import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/product_controller.dart';
import '../../../model/products_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/network_utili.dart';

class AddCartItemFloatWidget extends StatelessWidget {
  const AddCartItemFloatWidget({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return Obx(() {
      var isProductInCart = productController.isProductInCart.value;
      return FloatingActionButton.extended(
        backgroundColor:
            isProductInCart ? AppColors.red : AppColors.accentGreen,
        onPressed: isProductInCart
            ? () => AppsFunction.flutterToast(msg: AppString.itemAlreadyInCart)
            : () async {
                NetworkUtils.executeWithInternetCheck(action: () {
                  productController.addItemToCart(
                    productId: productModel.productId!,
                    sellerId: productModel.sellerId!,
                  );
                });
                /*
                if (!(await NetworkUtili.verifyInternetStatus())) {
                  productController.addItemToCart(
                    productId: productModel.productId!,
                    sellerId: productModel.sellerId!,
                  );
                }
                */
              },
        icon: Icon(
          Icons.shopping_cart,
          color: AppColors.white,
        ),
        label: Text(
          isProductInCart ? AppString.itemAlreadyInCart : AppString.addToCart,
          style: AppsTextStyle.buttonTextStyle,
        ),
      );
    });
  }
}
