import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/cart_controller.dart';
import '../../../res/app_colors.dart';
import '../../../model/products_model.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/cart_funtion.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/product_image_widget.dart';

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
    int quantity = CartFunctions.seperateProductQuantiyList()[index];
    var cartController = Get.find<CartController>();
    return InkWell(
      onTap: () => Get.toNamed(RoutesName.productDestailsPage,
          arguments: {"productModel": productModel, "isCartBack": true}),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            _buildProductCard(context, cartController, quantity),
            SizedBox(
              height: 4.h,
            ),
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
    final price = AppsFunction.productPrice(
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
                        style: AppsTextStyle.boldBodyTextStyle),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () async {
                      if (!(await AppsFunction.verifyInternetStatus())) {
                        cartController.removeProductFromCart(
                          productId: productModel.productId!,
                        );
                      }
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
            Row(
              children: [
                Text(productModel.productunit!.toString(),
                    style: AppsTextStyle.boldBodyTextStyle
                        .copyWith(color: AppColors.lightHintText)),
              ],
            ),
            Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${1 * quantity} * ",
                      style: GoogleFonts.poppins(
                          color: AppColors.accentGreen,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(price.toStringAsFixed(2),
                        style: AppsTextStyle.rattingText
                            .copyWith(color: AppColors.accentGreen)),
                  ],
                ),
                const Spacer(),
                Text(
                  "= ৳. ${total.toStringAsFixed(2)}",
                  style: AppsTextStyle.boldBodyTextStyle
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
