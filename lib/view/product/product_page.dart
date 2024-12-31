import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';
import '../../res/app_function.dart';

import '../../res/routes/routes_name.dart';
import '../../widget/product_list_widget.dart';
import 'widget/drop_down_category_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductListType productListType = Get.arguments as ProductListType;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(productListType == ProductListType.regular
            ? AppString.products
            : AppString.popularProduct),
        actions: [
          IconButton(
            onPressed: () async {
              if (!(await AppsFunction.verifyInternetStatus())) {
                Get.offAllNamed(RoutesName.mainPage, arguments: 2);
              }
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
              const DropdownCategoryWidget(),
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
