import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../model/productsmodel.dart';
import '../res/app_colors.dart';
import '../res/app_function.dart';
import '../res/textstyle.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({super.key, required this.quantity});
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    return Container(
      height: 110.h,
      width: 0.9.w,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(productModel),
          Expanded(
            child: _buildProductDetails(productModel, context),
          )
        ],
      ),
    );
  }

  Padding _buildProductDetails(ProductModel model, BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 20.w, right: 12.w, top: 15.h, bottom: 15.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              model.productname!,
              style: Textstyle.largestText.copyWith(fontSize: 16.sp),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Text(model.productunit!.toString(),
                  style: Textstyle.mediumTextbold.copyWith(
                    color: Theme.of(context).hintColor,
                  )),
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
                  Text("$quantity * ",
                      style: Textstyle.mediumText600
                          .copyWith(color: AppColors.greenColor)),
                  Text(
                      "${AppsFunction.productPrice(model.productprice!, model.discount!.toDouble())}",
                      style: Textstyle.mediumText600.copyWith(
                          letterSpacing: 1.2, color: AppColors.greenColor)),
                ],
              ),
              const Spacer(),
              Text(
                  "= ৳. ${AppsFunction.productPrice(model.productprice!, model.discount!.toDouble()) * quantity}",
                  style: Textstyle.mediumTextbold.copyWith(
                    color: AppColors.greenColor,
                    fontSize: 16.sp,
                    letterSpacing: 1.2,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Stack _buildProductImage(ProductModel model) {
    return Stack(
      children: [
        Container(
          height: 100.h,
          width: 120.w, //140
          alignment: Alignment.center,
          margin: EdgeInsets.all(10.r),
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
              color: AppColors.cardImageBg,
              borderRadius: BorderRadius.circular(5.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: FancyShimmerImage(
              height: 110.h,
              boxFit: BoxFit.contain,
              imageUrl: model.productimage![0],
            ),
          ),
        ),
        Positioned(
          left: 10.w,
          top: 10.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.red, width: .5),
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.lightred.withOpacity(.2),
            ),
            child: Text(
              "${model.discount}% Off",
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
