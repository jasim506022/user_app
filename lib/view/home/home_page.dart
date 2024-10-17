import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import '../../res/constant/string_constant.dart';
import '../../res/routes/routes_name.dart';

import '../../widget/product_list_widget.dart';
import 'widget/carousel_silder_widget.dart';
import 'widget/category_widget.dart';
import 'widget/popular_product_list_widget.dart';
import 'widget/row_widget.dart';
import 'widget/user_profile_header_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _setStatusBarStyle(context);
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                Column(
                  children: [
                    const UserProfileHeaderWidget(),
                    SizedBox(
                      height: 10.h,
                    ),
                    InkWell(
                      onTap: () async {
                        if (!(await AppsFunction.verifyInternetStatus())) {
                          Get.offAllNamed(RoutesName.mainPage, arguments: 2);
                        }
                      },
                      child: _buildSearchBar(context),
                    ),
                  ],
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: .25.sh,
                        width: 1.sw,
                        child: const CarouselSilderWidget(),
                      ),
                      SizedBox(height: 10.h),
                      const CategoryWidget(),
                      SizedBox(
                        height: 15.h,
                      ),
                      RowWidget(
                        text: StringConstant.popularProduct,
                        function: () async {
                          if (!(await AppsFunction.verifyInternetStatus())) {
                            Get.toNamed(RoutesName.productPage,
                                arguments: true);
                          }
                        },
                      ),
                      SizedBox(height: 10.h),
                      const PopularProductListWidget(),
                      SizedBox(
                        height: 10.h,
                      ),
                      RowWidget(
                        text: StringConstant.product,
                        function: () async {
                          if (!(await AppsFunction.verifyInternetStatus())) {
                            Get.toNamed(RoutesName.productPage,
                                arguments: false);
                          }
                        },
                      ),
                      const ProductListWidget(
                        isScroll: false,
                      )
                    ],
                  ),
                )),
              ],
            )),
      ),
    );
  }

  // Search
  Container _buildSearchBar(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 15.h),
      width: Get.width,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          children: [
            Text(
              StringConstant.searchint,
              style: AppsTextStyle.hintTextStyle,
            ),
            const Spacer(),
            Icon(
              IconlyLight.search,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: 10.w,
            ),
          ],
        ),
      ),
    );
  }

  void _setStatusBarStyle(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark));
  }
}
