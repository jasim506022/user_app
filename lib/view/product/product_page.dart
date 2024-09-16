import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/category_controller.dart';
import '../../res/constants.dart';

import '../../res/routes/routesname.dart';
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
            onPressed: () {
              Get.toNamed(RoutesName.mainPage, arguments: 2);
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
            _buildDropDownButton(context),
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

  DropdownButtonFormField<String> _buildDropDownButton(BuildContext context) {
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
      value: categoryController.getCategory,
      isExpanded: true,
      style: GoogleFonts.poppins(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700),
      focusColor: Theme.of(context).primaryColor,
      elevation: 16,
      items: allCategoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
        categoryController.setCategory(category: value!);
      },
    );
  }
}
