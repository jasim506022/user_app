import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../res/app_function.dart';

import '../../res/routes/routes_name.dart';
import '../../widget/product_list_widget.dart';
import 'widget/drop_down_category_widget.dart';

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
          SizedBox(
            width: 10.h,
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
