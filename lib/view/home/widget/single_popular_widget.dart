import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/routesname.dart';

import '../../../res/app_function.dart';
import '../../../res/app_colors.dart';
import '../../../res/Textstyle.dart';
import '../../../model/productsmodel.dart';
import '../../../res/cart_funtion.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    bool isCart =
        CartFunctions.separateProductID().contains(productModel.productId);

    return InkWell(
      onTap: () {
        Get.toNamed(RoutesName.productDestailsPage, arguments: productModel);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        child: Container(
          height: .17.sh,
          width: .8.sw,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black,
                  spreadRadius: .05,
                )
              ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: .145.sh,
                    width: .145.sh,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10.r),
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: AppColors.cardImageBg,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: FancyShimmerImage(
                        height: 120.h,
                        boxFit: BoxFit.contain,
                        imageUrl: productModel.productimage![0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10.w,
                    top: 10.h,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.red, width: .5.w),
                        borderRadius: BorderRadius.circular(15.r),
                        color: AppColors.lightred.withOpacity(.2),
                      ),
                      child: Text("${productModel.discount}% Off",
                          style: Textstyle.mediumText600),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 12.w, top: 15.h, bottom: 15.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                            style: Textstyle.largeText
                                .copyWith(color: AppColors.red),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            "${(productModel.productprice!)}",
                            style: Textstyle.mediumText400lineThrough,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: productModel.productname!,
                            style: Textstyle.largeText,
                          ),
                          TextSpan(
                            text: "(${productModel.productunit!})",
                            style: Textstyle.smallestText,
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 25.h,
                        // width: 1.sw,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          color: isCart ? AppColors.red : AppColors.greenColor,
                        ),
                        child: Text(
                          "Add To Cart",
                          style: Textstyle.largeText
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
