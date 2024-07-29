import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/product_controller.dart';
import '../../res/constants.dart';
import '../../service/provider/category_provider.dart';

import 'product_list_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  // final bool? isPopular;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var firebaseAllDataController = Get.put(ProductController(
    Get.find(),
  ));
  var categoryController = Get.put(CategoryController());

  // var isPopular = false;

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
            onPressed: () {},
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
      value: categoryController.getCategory,
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
        categoryController.setCategory(category: value!);
      },
    );
  }
}

/*
Widget buildProductList({bool? isPopular = false, bool? isMovie = true}) {
  final ProductController firebaseAllDataController =
      Get.put(ProductController(Get.find()));

  var categoryController = Get.put(CategoryController());

  return Obx(() => StreamBuilder(
        stream: isPopular!
            ? firebaseAllDataController.popularProductSnapshot(
                category: categoryController.getCategory)
            : firebaseAllDataController.productSnapshots(
                category: categoryController.getCategory),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingProductWidget();
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const EmptyWidget(
                image: 'asset/payment/empty.png', title: 'No Data Available');
          }
          if (snapshot.hasError) {
            return EmptyWidget(
                image: 'asset/payment/empty.png',
                title: 'Error Occured: ${snapshot.error}');
          }

          return GridView.builder(
            shrinkWrap: true,
            physics: isMovie!
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .78,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              ProductModel productModel =
                  ProductModel.fromMap(snapshot.data!.docs[index].data());
              return ChangeNotifierProvider.value(
                value: productModel,
                child: const ProductWidget(),
              );
            },
          );
        },
      ));
}
*/