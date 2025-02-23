import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../res/app_constant.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/app_colors.dart';
import '../../../res/utils.dart';
import '../../../controller/category_controller.dart';
import '../../../res/network_utili.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();

    return SizedBox(
      height: 40.h,
      width: 1.sw,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: AppConstant.cateogryTypes.length,
        itemBuilder: (context, index) {
          final category = AppConstant.cateogryTypes[index];
          return _buildCategoryItem(categoryController, category);
        },
      ),
    );
  }

  /// Builds an individual category item.

  Padding _buildCategoryItem(
      CategoryController categoryController, String category) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: InkWell(
        onTap: () async {
          NetworkUtils.executeWithInternetCheck(action: () {
            categoryController.setCategory(category: category);
          });
/*
          if (!(await NetworkUtili.verifyInternetStatus())) {
            categoryController.setCategory(category: category);
          }
*/
        },
        child: Obx(() {
          bool isSelected = categoryController.getCategory == category;

          /// Builds the styled container for a category item.

          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: isSelected
                    ? Utils.categorySelectBackground
                    : Utils.categoryUnselectBackground,
                borderRadius: BorderRadius.circular(30.r)),
            child: Text(category,
                style: AppsTextStyle.bodyTextStyle.copyWith(
                    color: isSelected
                        ? AppColors.white
                        : Utils.categoryUnSelectTextColor)),
          );
        }),
      ),
    );
  }
}
