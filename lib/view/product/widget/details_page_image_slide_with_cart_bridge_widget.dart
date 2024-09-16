import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/utils.dart';

import '../../../controller/cart_product_counter_controller.dart';
import '../../../model/productsmodel.dart';
import '../../../res/app_colors.dart';
import '../../../res/routes/routesname.dart';
import '../../../widget/cart_badge.dart';
import 'details_card_swiper.dart';

class DetailsPageImageSlideWithCartBridgeWidget extends StatelessWidget {
  const DetailsPageImageSlideWithCartBridgeWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    var cartProductCountController = Get.find<CartProductCountController>();
    Utils utils = Utils(context);
    return SizedBox(
      height: 300.h,
      width: 1.sw,
      child: Stack(
        children: [
          //understand this code carefully
          for (Map<String, dynamic> circleConfig in [
            {
              'left': -200.00.w,
              'right': -200.00.w,
              'top': -400.00.h,
              'size': 800.00.h,
              'color': utils.green100
            },
            {
              'left': -80.00.w,
              'right': -80.00.w,
              'top': -300.00.h,
              'size': 600.00.h,
              'color': utils.green200
            },
            {
              'left': 0.00,
              'right': 0.00,
              'top': -Get.width * 0.425,
              'size': Get.width * 0.85,
              'color': utils.green300
            },
          ])
            Positioned(
              left: circleConfig['left'],
              right: circleConfig['right'],
              top: circleConfig['top'],
              child: Container(
                height: circleConfig['size'],
                width: circleConfig['size'],
                decoration: BoxDecoration(
                  color: circleConfig['color'],
                  shape: BoxShape.circle,
                ),
              ),
            ),

          /*
          Positioned(
            left: -200,
            right: -200,
            top: -400,
            child: Container(
              height: 800,
              width: 800,
              decoration: BoxDecoration(
                  color: utils.green100, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: -80,
            right: -80,
            top: -300,
            child: Container(
              height: 600,
              width: 600,
              decoration: BoxDecoration(
                  color: utils.green200, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -Get.width * .425,
            child: Container(
              height: mq.width * .85,
              width: mq.width * .85,
              decoration: BoxDecoration(
                  color: utils.green300, shape: BoxShape.circle),
            ),
          ),
         */

          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                              color: AppColors.greenColor,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RoutesName.cartPage);
                        },
                        child: Obx(
                          () => Container(
                            height: 30.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                shape: BoxShape.circle),
                            child: CartBadge(
                              color: AppColors.white,
                              itemCount: cartProductCountController.getCounts,
                              icon: Icons.shopping_cart,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  DetailsSwiperWidget(productModel: productModel),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
