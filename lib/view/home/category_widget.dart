import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../res/utils.dart';
import '../../service/provider/category_provider.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.put(CategoryController());
    Utils utils = Utils(context);
    return SizedBox(
      height: mq.height * .058,
      width: mq.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: mq.width * .022),
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
                  padding: EdgeInsets.symmetric(
                      horizontal: mq.width * .044, vertical: mq.height * .015),
                  decoration: BoxDecoration(
                      color: isSelect
                          ? utils.categorySelectBackground
                          : utils.categoryUnselectBackground,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    allCategoryList[index],
                    style: GoogleFonts.poppins(
                        color: isSelect
                            ? AppColors.white
                            : utils.categoryUnSelectTextColor,
                        fontSize: 12,
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
