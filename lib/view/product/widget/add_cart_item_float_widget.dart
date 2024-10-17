import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/constant/string_constant.dart';

import '../../../controller/product_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';

class AddCartItemFloatWidget extends StatelessWidget {
  const AddCartItemFloatWidget({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();
    return Obx(
      () => FloatingActionButton.extended(
        backgroundColor: productController.isInCart.value
            ? AppColors.red
            : AppColors.greenColor,
        onPressed: productController.isInCart.value
            ? () => AppsFunction.flutterToast(msg: "Item is already in cart")
            : () async {
                if (!(await AppsFunction.verifyInternetStatus())) {
                  productController.addItemToCart(
                    productId: productModel.productId!,
                    sellerId: productModel.sellerId!,
                  );
                }
              },
        icon: Icon(
          Icons.shopping_cart,
          color: AppColors.white,
        ),
        label: Text(
          productController.isInCart.value
              ? StringConstant.itemAlreadyInCart
              : StringConstant.addToCart,
          style: AppsTextStyle.buttonTextStyle,
        ),
      ),
    );
  }
}
