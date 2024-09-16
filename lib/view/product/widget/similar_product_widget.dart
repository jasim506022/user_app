import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_colors.dart';

import '../../../model/productsmodel.dart';
import '../../../res/cart_funtion.dart';
import '../../../res/routes/routesname.dart';

class SimilarProductWidget extends StatelessWidget {
  const SimilarProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    bool isCart =
        CartFunctions.separateProductID().contains(productModel.productId);
    return InkWell(
      onTap: () {
        Get.offAndToNamed(
          RoutesName.productDestailsPage,
          arguments: productModel,
        );
      },
      child: Container(
        height: 150.h,
        width: 100.w,
        padding: EdgeInsets.all(10.r),
        margin: EdgeInsets.only(left: 15.w),
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: FancyShimmerImage(
                height: 80.h,
                boxFit: BoxFit.fill,
                imageUrl: productModel.productimage![0],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            FittedBox(
              child: Text(
                productModel.productname!,
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                    color:
                        isCart ? AppColors.red : Theme.of(context).primaryColor,
                    fontSize: 13.sp,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
