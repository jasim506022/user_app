import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/product_controller.dart';
import '../../res/constants.dart';

import '../../res/routes/routesname.dart';
import 'product_list_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var productController = Get.put(ProductController(
    Get.find(),
  ));

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
        elevation: 0.3,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            _buildDropDownButton(),
            const SizedBox(
              height: 15,
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

// Understand this code
  DropdownButtonFormField<String> _buildDropDownButton() {
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
      value: productController.categoryController.getCategory,
      isExpanded: true,
      style: GoogleFonts.poppins(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700),
      focusColor: Theme.of(context).primaryColor,
      elevation: 16,
      // Understand this code on dart
      items: allCategoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
        productController.categoryController.setCategory(category: value!);
      },
    );
  }
}
