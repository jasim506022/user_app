import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/Textstyle.dart';
import 'package:user_app/res/routes/routesname.dart';

import '../../res/app_function.dart';
import '../../res/app_colors.dart';
import '../../model/productsmodel.dart';
import '../cart/dot_line_printer.dart';

class DeliveryCartWidget extends StatelessWidget {
  const DeliveryCartWidget({
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
    // Textstyle Textstyle = Textstyle(context);
    return InkWell(
      onTap: () {
        Get.toNamed(RoutesName.productDestailsPage, arguments: productModel);

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ProductDetailsPage(
        //         productModel: productModel,
        //       ),
        //     ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 110.h,
                        width: 140.w,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: AppColors.cardImageBg,
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FancyShimmerImage(
                            height: 120.h,
                            boxFit: BoxFit.contain,
                            imageUrl: productModel.productimage![0],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.red, width: .5),
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.lightred.withOpacity(.2),
                          ),
                          child: Text(
                            "${productModel.discount}% Off",
                            style: GoogleFonts.poppins(
                              color: AppColors.red,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                          FittedBox(
                            child: Text(productModel.productname!,
                                style: Textstyle.largeBoldText.copyWith(
                                    color: Theme.of(context).primaryColor)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            productModel.productunit!.toString(),
                            style: Textstyle.mediumTextbold
                                .copyWith(color: Theme.of(context).hintColor),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("${1 * itemQunter} * ",
                                      style: Textstyle.mediumText600.copyWith(
                                          color: AppColors.greenColor)),
                                  Text(
                                      "${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                                      style: Textstyle.mediumText600.copyWith(
                                          color: AppColors.greenColor)),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                  "= ৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble()) * itemQunter}",
                                  style: Textstyle.largeBoldText.copyWith(
                                      color: AppColors.greenColor,
                                      letterSpacing: 1.2)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Adjust the width as needed
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
