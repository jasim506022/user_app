import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../res/routes/routes_name.dart';

import '../../widget/product_list_widget.dart';
import 'widget/carousel_silder_widget.dart';
import 'widget/category_widget.dart';
import '../../res/network_utili.dart';
import 'widget/popular_product_list_widget.dart';
import 'widget/row_widget.dart';
import 'widget/user_profile_header_widget.dart';

/// The main home page of the app, displaying a user profile,
/// carousel slider, categories, and lists of popular and all products.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                Column(
                  children: [
                    // Displays the user's profile information.
                    const UserProfileHeaderWidget(),
                    AppsFunction.verticalSpacing(10),
                    InkWell(
                      onTap: () async {
                        Get.offAllNamed(AppRoutesName.mainPage, arguments: 2);
                      },
                      child: _buildSearchBar(context),
                    ),
                  ],
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// Builds the main body content with a carousel, categories, and product lists.
                      SizedBox(
                        height: .25.sh,
                        width: 1.sw,
                        child: const CarouselSilderWidget(),
                      ),
                      AppsFunction.verticalSpacing(10),
                      const CategoryWidget(), // Displays the categories of products.
                      AppsFunction.verticalSpacing(15),
                      // Popular Products Section

                      RowWidget(
                        text: AppString.popularProduct,
                        onTap: () async {
                          if (!(await NetworkUtili.verifyInternetStatus())) {
                            Get.toNamed(AppRoutesName.productListPage,
                                arguments: ProductListType.popular);
                          }
                        },
                      ),
                      AppsFunction.verticalSpacing(10),
                      const PopularProductListWidget(),
                      AppsFunction.verticalSpacing(10),

                      // All Products Section
                      RowWidget(
                        text: AppString.products,
                        onTap: () async {
                          if (!(await NetworkUtili.verifyInternetStatus())) {
                            Get.toNamed(AppRoutesName.productListPage,
                                arguments: ProductListType.regular);
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

  /// Builds the search bar widget.
  Container _buildSearchBar(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 15.h),
      width: 1.sw,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Padding(
        padding: EdgeInsets.only(left: 30.w),
        child: Row(
          children: [
            Text(
              AppString.searchHint,
              style: AppsTextStyle.hintTextStyle,
            ),
            const Spacer(),
            Icon(
              IconlyLight.search,
              color: Theme.of(context).primaryColor,
            ),
            AppsFunction.horizontalSpacing(10)
          ],
        ),
      ),
    );
  }
}
