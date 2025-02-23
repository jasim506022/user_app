import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/utils.dart';

import '../../../controller/cart_controller.dart';

import '../../../model/products_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/cart_badge.dart';
import '../../../res/network_utili.dart';
import 'details_image_swiper_widget.dart';

class DetailsPageImageSlideWithCartBridgeWidget extends StatelessWidget {
  const DetailsPageImageSlideWithCartBridgeWidget({
    super.key,
    required this.productModel,
    this.backCart = false,
  });

  final ProductModel productModel;
  final bool backCart;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320.h,
      width: 1.sw,
      child: Stack(
        children: [
          ..._buildBackgroundCircles(),
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppsFunction.verticalSpacing(10),
                  _buildTopBar(),
                  DetailsImageSwiperWidget(productModel: productModel),
                  AppsFunction.verticalSpacing(10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // This method builds the background circles
  List<Widget> _buildBackgroundCircles() {
    List<Map<String, dynamic>> circleConfig = [
      {
        'left': -300.00.w,
        'right': -300.00.w,
        'top': -350.00.h,
        'size': 650.00.h,
        'color': Utils.green100
      },
      {
        'left': -80.00.w,
        'right': -80.00.w,
        'top': -360.00.h,
        'size': 650.00.h,
        'color': Utils.green200
      },
      {
        'left': 0.00,
        'right': 0.00,
        'top': -150.00.w,
        'size': 300.00.h,
        'color': Utils.green300
      },
    ];

    return circleConfig.map((circle) {
      return Positioned(
        left: circle['left'],
        right: circle['right'],
        top: circle['top'],
        child: Container(
          height: circle['size'],
          width: circle['size'],
          decoration: BoxDecoration(
            color: circle['color'],
            shape: BoxShape.circle,
          ),
        ),
      );
    }).toList();
  }

  // This method builds the top bar with back and cart buttons
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: _buildCircularButton(
            Icon(Icons.arrow_back_ios, color: AppColors.white, size: 25),
          ),
        ),
        InkWell(
          onTap: () async {
            NetworkUtils.executeWithInternetCheck(action: () {
              Get.toNamed(AppRoutesName.cartPage);
            });
            /*
            if (!(await NetworkUtili.verifyInternetStatus())) {
              Get.toNamed(AppRoutesName.cartPage);
            }
            */
          },
          child: _buildCircularButton(
            Obx(
              () => CartBadge(
                color: AppColors.white,
                itemCount: Get.find<CartController>().itemCount,
                icon: Icons.shopping_cart,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build a circular button
  Container _buildCircularButton(Widget widget) {
    return Container(
      height: 50.h,
      width: 50.h,
      decoration: BoxDecoration(
        color: AppColors.accentGreen,
        shape: BoxShape.circle,
      ),
      child: widget,
    );
  }
}


/*

class DetailsPageImageSlideWithCartBridgeWidget extends StatelessWidget {
  const DetailsPageImageSlideWithCartBridgeWidget({
    super.key,
    required this.productModel,
    this.backCart = false,
  });

  final ProductModel productModel;
  final bool backCart;

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
    return SizedBox(
      height: 320.h,
      width: 1.sw,
      child: Stack(
        children: [
          //understand this code carefully
          for (Map<String, dynamic> circleConfig in [
            {
              'left': -300.00.w,
              'right': -300.00.w,
              'top': -350.00.h,
              'size': 650.00.h,
              'color': utils.green100
            },
            {
              'left': -80.00.w,
              'right': -80.00.w,
              'top': -360.00.h,
              'size': 650.00.h,
              'color': utils.green200
            },
            {
              'left': 0.00,
              'right': 0.00,
              'top': -150.00.w,
              'size': 300.00.h,
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
          Positioned(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppsFunction.verticleSpace(10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: _buildCircularButton(
                          Icon(
                            Icons.arrow_back_ios,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            if (!(await AppsFunction.verifyInternetStatus())) {
                              Get.toNamed(RoutesName.cartPage);
                            }
                          },
                          child: _buildCircularButton(
                            Obx(
                              () => CartBadge(
                                color: AppColors.white,
                                itemCount: Get.find<CartController>().itemCount,
                                icon: Icons.shopping_cart,
                              ),
                            ),
                          ))
                    ],
                  ),
                 
                  DetailsImageSwiperWidget(productModel: productModel),
                  AppsFunction.verticleSpace(10)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildCircularButton(Widget widget) {
    return Container(
        height: 50.h,
        width: 50.h,
        decoration:
            BoxDecoration(color: AppColors.accentGreen, shape: BoxShape.circle),
        child: widget);
  }
}


*/




/*


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

*/

/*
          Positioned(
            left: -300,
            right: -300,
            top: -450,
            child: Container(
              height: 700,
              width: 700,
              decoration:
                  BoxDecoration(color: utils.green100, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: -80,
            right: -80,
            top: -380,
            child: Container(
              height: 650,
              width: 650,
              decoration:
                  BoxDecoration(color: utils.green200, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: -150,
            child: Container(
              height: 300,
              width: 300,
              decoration:
                  BoxDecoration(color: utils.green300, shape: BoxShape.circle),
            ),
          ),
          */
