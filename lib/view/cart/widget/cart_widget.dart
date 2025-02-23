import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../../../controller/cart_controller.dart';
import '../../../res/app_colors.dart';
import '../../../model/products_model.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/cart_funtion.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/product_image_widget.dart';
import '../../../res/network_utili.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.productModel,
    required this.index,
  });
  final ProductModel productModel;

  final int index;

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    int quantity = CartManager.getProductQuantities()[index];

    return InkWell(
      onTap: () => Get.toNamed(AppRoutesName.productDetailsPage, arguments: {
        AppString.productModel: productModel,
        AppString.isCartBack: true
      }),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            _buildProductCard(context, cartController, quantity),
            AppsFunction.verticalSpacing(10)
          ],
        ),
      ),
    );
  }

  Container _buildProductCard(
      BuildContext context, CartController cartController, int quantity) {
    return Container(
      height: 110.h,
      width: 0.9.sw,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImageWidget(
            productModel: productModel,
            height: 110.h,
            imageHeith: 110.h,
            width: 110.h,
          ),
          _buildProductDetails(context, cartController, quantity)
        ],
      ),
    );
  }

  Expanded _buildProductDetails(
      BuildContext context, CartController cartController, int quantity) {
    final price = AppsFunction.calculateDiscountedPrice(
      productModel.productprice!,
      productModel.discount!.toDouble(),
    );

    final total = price * quantity;
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 12.w, top: 5.h, bottom: 5.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: FittedBox(
                    child: Text(productModel.productname!,
                        style: AppsTextStyle.bodyTextStyle),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      NetworkUtils.executeWithInternetCheck(action: () {
                        cartController.removeProductFromCart(
                          productId: productModel.productId!,
                        );
                      });
                      /*
                      if (!(await NetworkUtili.verifyInternetStatus())) {
                        cartController.removeProductFromCart(
                          productId: productModel.productId!,
                        );
                      }
*/

                      cartController.removeValue(total);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.red, width: 2),
                          borderRadius: BorderRadius.circular(15)),
                      child: Icon(
                        Icons.remove,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(productModel.productunit!.toString(),
                style: AppsTextStyle.bodyTextStyle
                    .copyWith(color: AppColors.hintTextlight)),
            Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("$quantity * ${price.toStringAsFixed(2)}",
                        style: AppsTextStyle.rattingText
                            .copyWith(color: AppColors.accentGreen)),
                  ],
                ),
                const Spacer(),
                Text(
                  "= ${AppString.currencyIcon}. ${total.toStringAsFixed(2)}",
                  style: AppsTextStyle.bodyTextStyle
                      .copyWith(color: AppColors.accentGreen),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
