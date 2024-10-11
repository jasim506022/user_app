import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/cart_controller.dart';
import '../../res/app_colors.dart';
import '../../model/productsmodel.dart';
import '../../res/app_function.dart';
import '../../res/routes/routes_name.dart';
import 'dot_line_printer.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.productModel,
    required this.itemQunter,
    required this.index,
  });
  final ProductModel productModel;
  final int itemQunter;
  final int index;

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return InkWell(
      onTap: () =>
          Get.toNamed(RoutesName.productDestailsPage, arguments: productModel),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            _buildProductCard(context, cartController),
            SizedBox(
              height: 4.h,
            ),
            SizedBox(
              width: 1.sw,
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildProductCard(
      BuildContext context, CartController cartController) {
    return Container(
      height: 92.h,
      width: 0.9.sw,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImageWithDiscoundBridge(),
          _buildProductDetails(context, cartController)
        ],
      ),
    );
  }

  Expanded _buildProductDetails(
      BuildContext context, CartController cartController) {
    final price = AppsFunction.productPrice(
      productModel.productprice!,
      productModel.discount!.toDouble(),
    );

    final total = price * itemQunter;
    return Expanded(
      child: Padding(
        padding:
            EdgeInsets.only(left: 20.w, right: 12.w, top: 15.h, bottom: 15.h),
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
                    child: Text(
                      productModel.productname!,
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () async => cartController.removeProductFromCart(
                      productId: productModel.productId!,
                    ),
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
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Text(
                  productModel.productunit!.toString(),
                  style: GoogleFonts.poppins(
                      color: Theme.of(context).hintColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${1 * itemQunter} * ",
                      style: GoogleFonts.poppins(
                          color: AppColors.greenColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      price.toStringAsFixed(2),
                      style: GoogleFonts.poppins(
                          color: AppColors.greenColor,
                          fontSize: 13.sp,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  "= ৳. ${total.toStringAsFixed(2)}",
                  style: GoogleFonts.poppins(
                      color: AppColors.greenColor,
                      fontSize: 14.sp,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Stack _buildProductImageWithDiscoundBridge() {
    return Stack(
      children: [
        Container(
          height: 70.h,
          width: 110.w,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.cardImageBg,
              borderRadius: BorderRadius.circular(5.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: FancyShimmerImage(
              height: 65.h,
              boxFit: BoxFit.contain,
              imageUrl: productModel.productimage![0],
            ),
          ),
        ),
        Positioned(
          left: 10.w,
          top: 10.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 5.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.red, width: .5),
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.lightred.withOpacity(.2),
            ),
            child: Text(
              "${productModel.discount}% Off",
              style: GoogleFonts.poppins(
                color: AppColors.red,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
