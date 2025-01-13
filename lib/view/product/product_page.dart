import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/constants.dart';
import '../../controller/category_controller.dart';
import '../../res/app_function.dart';

import '../../res/app_string.dart';
import '../../res/routes/routes_name.dart';
import '../../widget/product_list_widget.dart';
import 'widget/drop_down_category_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductListType? productListType = Get.arguments;
    productListType ??= ProductListType.regular;
    var categoryController = Get.find<CategoryController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(productListType == ProductListType.regular
            ? AppString.products
            : AppString.popularProduct),
        actions: [
          IconButton(
            onPressed: () {
              Get.offAllNamed(RoutesName.mainPage, arguments: 2);
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
          AppsFunction.horizontalSpace(10)
        ],
        //
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            if (productListType == ProductListType.regular) ...[
              DropdownCategoryWidget(
                value: categoryController.getCategory,
                list: allCategoryList,
                onChanged: (p0) {
                  categoryController.setCategory(category: p0!);
                },
              ),
              AppsFunction.verticleSpace(15)
            ],
            Expanded(
                child: ProductListWidget(productListType: productListType)),
          ],
        ),
      ),
    );
  }
}
