import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/routesname.dart';
import '../res/app_function.dart';
import '../res/cart_funtion.dart';

import '../../res/app_colors.dart';
import '../res/Textstyle.dart';
import '../model/productsmodel.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
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
      child: Card(
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.white,
                  spreadRadius: .08,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: .125.sh,
                    alignment: Alignment.center,
                    margin: EdgeInsets.all(10.r),
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: AppColors.cardImageBg,
                        borderRadius: BorderRadius.circular(5.r)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: FancyShimmerImage(
                        height: .85.sh,
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
                        border: Border.all(color: AppColors.red, width: .5),
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
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        height: 2.h,
                      ),
                      FittedBox(
                        child: Text(
                          productModel.productname!,
                          style: Textstyle.largeText,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.productDestailsPage,
                                arguments: productModel);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40, //.045.sh,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color:
                                  isCart ? AppColors.red : AppColors.greenColor,
                            ),
                            child: Text(
                              "Add To Cart",
                              style: Textstyle.largeText.copyWith(
                                  color: AppColors.white, fontSize: 14.sp),
                            ),
                          )),
                      SizedBox(
                        height: 7.h,
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
