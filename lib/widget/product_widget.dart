import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/routesname.dart';
import '../res/app_function.dart';
import '../res/cartmethod.dart';
import '../res/constants.dart';
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
    
    bool isCart = false;
    List<String> productIdListFromCartLish =
        CartMethods.separeteProductIdUserCartList();
    if (productIdListFromCartLish.contains(productModel.productId)) {
      isCart = true;
    }
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
              borderRadius: BorderRadius.circular(20),
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
                    height:    .125.sh,
                    // mqs(context).height * .125,
                    alignment: Alignment.center,
                    margin:  EdgeInsets.all(10.r),
                    padding:  EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: AppColors.cardImageBg,
                        borderRadius: BorderRadius.circular(5).w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: .85.sh,
                        boxFit: BoxFit.contain,
                        imageUrl: productModel.productimage![0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 5.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.red, width: .5),
                        borderRadius: BorderRadius.circular(15),
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
                  padding: const EdgeInsets.only(left: 12, right: 12),
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
                            width: 15,
                          ),
                          Text(
                            "${(productModel.productprice!)}",
                            style: Textstyle.mediumText400lineThrough,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      FittedBox(
                        child: Text(
                          productModel.productname!,
                          style: Textstyle.largeText,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Get.toNamed(RoutesName.productDestailsPage,
                                arguments: productModel);
                         
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: .045.sh,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  isCart ? AppColors.red : AppColors.greenColor,
                            ),
                            child: Text(
                              "Add To Cart",
                              style: Textstyle.largeText.copyWith(
                                  color: AppColors.white, fontSize: 14),
                            ),
                          )),
                      const SizedBox(
                        height: 7,
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
