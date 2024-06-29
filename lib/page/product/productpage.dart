import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../res/constants.dart';
import '../../model/productsmodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/category_provider.dart';
import '../../widget/empty_widget.dart';
import '../../widget/loading_product_widget.dart';
import '../../widget/product_widget.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, this.isPopular = false});

  final bool? isPopular;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          widget.isPopular! ? "Popular Product" : "Products",
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
            Consumer<CategoryProvider>(
              builder: (context, dropvaluesall, child) {
                return _buildDropDownButton(dropvaluesall);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, value, child) {
                  return StreamBuilder(
                    stream: widget.isPopular!
                        ? FirebaseDatabase.popularProductSnapshot(
                            category: value.getCategory)
                        : FirebaseDatabase.productSnapshots(
                            category: value.getCategory),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const LoadingProductWidget();
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'No Data Available',
                        );
                      } else if (snapshot.hasError) {
                        return EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'Error Occure: ${snapshot.error}',
                        );
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: .78,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            ProductModel productModel = ProductModel.fromMap(
                                snapshot.data!.docs[index].data());
                            return ChangeNotifierProvider.value(
                              value: productModel,
                              child: const ProductWidget(),
                            );
                          },
                        );
                      }
                      return const LoadingProductWidget();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

// Understand this code
  DropdownButtonFormField<String> _buildDropDownButton(
      CategoryProvider dropvaluesall) {
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
      value: dropvaluesall.getCategory,
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
        Provider.of<CategoryProvider>(context, listen: false)
            .setCategory(category: value!);
      },
    );
  }
}
