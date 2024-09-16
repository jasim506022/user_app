import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../res/constants.dart';
import '../../../res/app_colors.dart';
import '../../../res/utils.dart';
import '../../../controller/category_controller.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();
    Utils utils = Utils(context);
    return SizedBox(
      height: 40.h,
      width: 1.sw,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: InkWell(
              onTap: () {
                categoryController.setCategory(
                    category: allCategoryList[index]);
              },
              child: Obx(() {
                bool isSelect =
                    categoryController.getCategory == allCategoryList[index];
                return Container(
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: isSelect
                          ? utils.categorySelectBackground
                          : utils.categoryUnselectBackground,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Text(
                    allCategoryList[index],
                    style: GoogleFonts.poppins(
                        color: isSelect
                            ? AppColors.white
                            : utils.categoryUnSelectTextColor,
                        fontSize: 12.sp,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700),
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
