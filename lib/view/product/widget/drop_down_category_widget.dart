import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/category_controller.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/constants.dart';

class DropdownCategoryWidget extends StatelessWidget {
  const DropdownCategoryWidget({
    super.key,
    this.isSearch = false,
    this.onChanged,
    this.category,
  });
  final String? category;
  final bool isSearch;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15.r)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15.r)),
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
      ),
      value: isSearch ? category : categoryController.getCategory,
      isExpanded: true,
      style: AppsTextStyle.boldBodyTextStyle,
      focusColor: Theme.of(context).primaryColor,
      elevation: 16,

      /// Builds the dropdown menu items from the category list.
      items: allCategoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: isSearch
          ? onChanged
          : (value) {
              categoryController.setCategory(category: value!.toString());
            },
    );
  }
}
