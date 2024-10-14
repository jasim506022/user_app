import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/apps_text_style.dart';

import '../../controller/category_controller.dart';
import '../../res/app_function.dart';
import '../../res/constants.dart';

import '../../res/routes/routes_name.dart';
import '../../widget/product_list_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPopular = Get.arguments;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          isPopular ? "Popular Product" : "Products",
        ),
        actions: [
          IconButton(
            onPressed: () async {
              if (!(await AppsFunction.verifyInternetStatus())) {
                Get.toNamed(RoutesName.mainPage, arguments: 2);
              }
            },
            icon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        //
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            const DropdownCategoryWidget(),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
                child: ProductListWidget(
              isPopular: isPopular,
            )),
          ],
        ),
      ),
    );
  }
}

class DropdownCategoryWidget extends StatelessWidget {
  const DropdownCategoryWidget({
    super.key,
    this.isSearch = false,
    this.onChanged,
    this.category,
  });
  final String? category;
  final bool? isSearch;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();
    return DropdownButtonFormField(
      decoration: InputDecoration(
        fillColor: Theme.of(context).cardColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 1),
            borderRadius: BorderRadius.circular(15)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      value: isSearch! ? category : categoryController.getCategory,
      isExpanded: true,
      style: AppsTextStyle.boldBodyTextStyle,
      focusColor: Theme.of(context).primaryColor,
      elevation: 16,
      items: allCategoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: isSearch!
          ? onChanged
          : (value) {
              categoryController.setCategory(category: value!.toString());
            },
    );
  }
}
