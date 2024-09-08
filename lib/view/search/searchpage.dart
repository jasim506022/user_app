import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../controller/search_controller.dart';
import '../../res/appasset/image_asset.dart';
import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../model/productsmodel.dart';
import '../../service/provider/category_provider.dart';
import '../../widget/empty_widget.dart';
import '../../widget/product_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = Get.put(SearchControllers());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Search Products",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 0.1.sh,
                width: 1.sw,
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: TextField(
                        controller: searchController.searchTextTEC,
                        onChanged: (text) {
                          searchController.searchList.clear();
                          final searchText = text.toLowerCase();
                          if (searchController.isfilter.value) {
                            for (var productModel
                                in searchController.filterList) {
                              if (_productMatchesSearch(
                                  productModel, searchText)) {
                                searchController.searchAddProduct(
                                    productModel: productModel);
                              }
                            }
                          } else {
                            for (var productModel
                                in searchController.allProducts) {
                              if (_productMatchesSearch(
                                  productModel, searchText)) {
                                searchController.searchAddProduct(
                                    productModel: productModel);
                              }
                            }
                          }
                          searchController.setSearch(true);
                          // print(searchController.isSearchList.value);
                          // print(searchController..value);
/*
                          if (_isfilter) {
                            for (var i in _filterList) {
                              if (i.productname!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase()) ||
                                  i.productdescription!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase())) {
                                _searchList.add(i);
                                setState(() {
                                  _searchList;
                                  _isSearchList = true;
                                });
                              }
                            }
                          } else {
                            for (var i in _allProducts) {
                              if (i.productname!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase()) ||
                                  i.productcategory!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase())) {
                                _searchList.add(i);
                                setState(() {
                                  _searchList;
                                  _isSearchList = true;
                                });
                              }
                            }
                          }
*/
                        },
                        decoration:
                            inputDecoration(hint: 'Search Seller here...'),
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(
                                  'Filter Data',
                                  style: GoogleFonts.roboto(
                                      color: AppColors.greenColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Product Price',
                                      style: GoogleFonts.roboto(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        _buildPriceTextField(
                                            controller:
                                                searchController.minPriceTEC,
                                            hintText: "Minium"),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        _buildPriceTextField(
                                            controller:
                                                searchController.maxPriceTEC,
                                            hintText: "Maximum"),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Product Category',
                                      style: GoogleFonts.roboto(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CategoryWiget(),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.greenColor,
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      searchController
                                        ..setFilter(false)
                                        ..categoryController
                                            .setCategory(category: "All");
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Close',
                                      style: GoogleFonts.roboto(
                                          color: AppColors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.greenColor,
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      searchController.filterList.clear();
                                      double minPrice = double.parse(
                                          searchController.minPriceTEC.text);
                                      double maxPrice = double.parse(
                                          searchController.maxPriceTEC.text);
                                      String category = searchController
                                          .categoryController.getCategory
                                          .toLowerCase();

                                      for (var productModel
                                          in searchController.allProducts) {
                                        final priceInRange =
                                            productModel.productprice! >=
                                                    minPrice &&
                                                productModel.productprice! <=
                                                    maxPrice;
                                        final matchesCategory =
                                            category == "all" ||
                                                productModel.productcategory!
                                                    .toLowerCase()
                                                    .contains(category);

                                        if (priceInRange && matchesCategory) {
                                          searchController.filterAddProduct(
                                              productModel: productModel);
                                        }
/*
                                        if (category == "All".toLowerCase()) {
                                          if (productModel.productprice! >=
                                                  minPrice &&
                                              productModel.productprice! <=
                                                  maxPrice) {
                                            searchController.filterAddProduct(
                                                productModel: productModel);
                                          }
                                        } else {
                                          if ((productModel.productprice! >=
                                                      minPrice &&
                                                  productModel.productprice! <=
                                                      maxPrice) &&
                                              productModel.productcategory!
                                                  .toLowerCase()
                                                  .contains(category)) {
                                            searchController.filterAddProduct(
                                                productModel: productModel);
                                          }
                                        }

*/
                                      }

                                      searchController.setFilter(true);

                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save',
                                        style: GoogleFonts.roboto(
                                            color: AppColors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.sliders,
                          color: AppColors.greenColor,
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                stream: searchController.productSnapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    searchController.allProducts.value = snapshot.data!.docs
                        .map((e) => ProductModel.fromMap(e.data()))
                        .toList();

                    return Obx(
                      () => GridView.builder(
                        itemCount: searchController.isfilter.value &&
                                searchController.searchTextTEC.text == ""
                            ? searchController.filterList.length
                            : searchController.isSearchList.value &&
                                    searchController
                                        .searchTextTEC.text.isNotEmpty
                                ? searchController.searchList.length
                                : searchController.allProducts.length,
                        // _isSearchList
                        //     ? _searchList.length
                        //     : _filterList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: .78,
                                childAspectRatio: .72,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          ProductModel productModel = ProductModel.fromMap(
                              snapshot.data!.docs[index].data());
                          return ChangeNotifierProvider.value(
                            value: searchController.isfilter.value &&
                                    searchController.searchTextTEC.text == ""
                                ? searchController.filterList[index]
                                : searchController.isSearchList.value &&
                                        searchController
                                            .searchTextTEC.text.isNotEmpty
                                    ? searchController.searchList[index]
                                    : searchController.allProducts[index],
                            // _isSearchList
                            //     ? _searchList[index]
                            //     : _filterList[index],
                            child: const ProductWidget(),
                          );
                        },
                      ),
                    );
                  }

                  return EmptyWidget(
                      image: ImagesAsset.error, title: "Now Data Found");
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildPriceTextField(
      {required TextEditingController controller, required String hintText}) {
    return Expanded(
      child: TextField(
        style: TextStyle(color: AppColors.black),
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: inputDecoration(hint: hintText),
      ),
    );
  }

  bool _productMatchesSearch(ProductModel product, String searchText) {
    return product.productname!.toLowerCase().contains(searchText);
  }

  InputDecoration inputDecoration({required String hint}) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }
}

class CategoryWiget extends StatelessWidget {
  const CategoryWiget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var searchController = Get.put(SearchControllers());
    // var categoryController = Get.put(CategoryController());
    return DropdownButtonFormField(
      decoration: InputDecoration(
        fillColor: const Color(0xfff2f2f8),
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      value: searchController.categoryController.getCategory,
      isExpanded: true,
      style: GoogleFonts.poppins(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
      focusColor: Colors.black,
      elevation: 16,
      items: allCategoryList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (value) {
        searchController.categoryController.setCategory(category: value!);
        // searchController.setFilter(true);
        // Provider.of<CategoryProvider>(context, listen: false)
        //     .setCategory(category: value!);
      },
    );
  }
}

/// for Work
/*
 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: mqs(context).height * .1,
                width: mqs(context).width,
                child: Row(
                  children: [
                    Flexible(
                      flex: 4,
                      child: TextField(
                        onChanged: (textEntered) {
                          _searchList.clear();
                          if (_isfilter) {
                            for (var i in _filterList) {
                              if (i.productname!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase()) ||
                                  i.productdescription!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase())) {
                                _searchList.add(i);
                                setState(() {
                                  _searchList;
                                  _isSearchList = true;
                                });
                              }
                            }
                          } else {
                            for (var i in _list) {
                              if (i.productname!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase()) ||
                                  i.productcategory!
                                      .toLowerCase()
                                      .contains(textEntered.toLowerCase())) {
                                _searchList.add(i);
                                setState(() {
                                  _searchList;
                                  _isSearchList = true;
                                });
                              }
                            }
                          }
                        },
                        decoration:
                            inputDecoration(hint: 'Search Seller here...'),
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                title: Text(
                                  'Filter Data',
                                  style: GoogleFonts.roboto(
                                      color: AppColors.greenColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Product Price',
                                      style: GoogleFonts.roboto(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            style: TextStyle(
                                                color: AppColors.black),
                                            controller: minController,
                                            keyboardType: TextInputType.number,
                                            decoration:
                                                inputDecoration(hint: "Minium"),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: TextField(
                                            style: TextStyle(
                                                color: AppColors.black),
                                            controller: maxController,
                                            keyboardType: TextInputType.number,
                                            decoration: inputDecoration(
                                                hint: "Maximum"),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Product Category',
                                      style: GoogleFonts.roboto(
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const CategoryWiget(),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.greenColor,
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Close',
                                      style: GoogleFonts.roboto(
                                          color: AppColors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.greenColor,
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      _filterList.clear();
                                      for (var i in _list) {
                                        if (categoryController.getCategory
                                                .toLowerCase() ==
                                            "All".toLowerCase()) {
                                          if ((i.productprice! >=
                                                  double.parse(
                                                      minController.text) &&
                                              i.productprice! <=
                                                  double.parse(
                                                      maxController.text))) {
                                            _filterList.add(i);
                                            setState(() {
                                              _filterList;
                                              _isfilter = true;
                                            });
                                          }
                                        } else {
                                          if ((i.productprice! >= min &&
                                                  i.productprice! <= max) &&
                                              i.productcategory!.contains(
                                                  categoryController
                                                      .getCategory)) {
                                            _filterList.add(i);
                                            setState(() {
                                              _filterList;
                                              _isfilter = true;
                                            });
                                          }
                                        }
                                      }

                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Save',
                                        style: GoogleFonts.roboto(
                                            color: AppColors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.sliders,
                          color: AppColors.greenColor,
                        ))
                  ],
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseDatabase.data,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final productData = snapshot.data!.docs;

                    _list = productData
                        .map((e) => ProductModel.fromMap(e.data()))
                        .toList();

                    if (_list.isNotEmpty) {
                      return GridView.builder(
                        itemCount: _isSearchList
                            ? _searchList.length
                            : _filterList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // childAspectRatio: .78,
                                childAspectRatio: .72,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                            value: _isSearchList
                                ? _searchList[index]
                                : _filterList[index],
                            child: const ProductWidget(),
                          );
                        },
                      );
                    }
                  }

                  return EmptyWidget(
                      image: ImagesAsset.error, title: "Now Data Found");
                },
              )),
            ],
          ),
        ),
      
      
*/


/*
 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Consumer<SearchTextProvider>(
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (textEntered) {
                        Provider.of<SearchTextProvider>(context, listen: false)
                            .setDroupValue(selectValue: textEntered);

                        initailizeSearchingProduct(value.searchText);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xff00B761), width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xff00B761), width: 1),
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "Search Seller here...",
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            initailizeSearchingProduct(value.searchText);
                          },
                          icon: const Icon(Icons.search),
                          color: Colors.grey,
                        ),
                      ),
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: storesDocumentList,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingProductWidget();
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: .75,
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
                ),
              ),
            ],
          ),
        ),
     
     */

/*
       
        Column(
          children: [
            Consumer<SearchTextProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (textEntered) {
                      _searchList.clear();
                      for (var i in _list) {
                        if (i.productname!
                                .toLowerCase()
                                .contains(textEntered.toLowerCase()) ||
                            i.productcategory!
                                .toLowerCase()
                                .contains(textEntered.toLowerCase())) {
                          _searchList.add(i);
                          setState(() {
                            _searchList;
                          });
                        }
                      }
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff00B761), width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff00B761), width: 1),
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Search Seller here...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () {
                          initailizeSearchingProduct(value.searchText);
                        },
                        icon: const Icon(Icons.search),
                        color: Colors.grey,
                      ),
                    ),
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: Consumer<CategoryProvider>(
                builder: (context, value, child) {
                  return StreamBuilder(
                    stream: FirebaseDatabase.data,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final productData = snapshot.data!.docs;

                        _list = productData
                            .map((e) => ProductModel.fromMap(e.data()))
                            .toList();

                        if (_list.isNotEmpty) {
                          return GridView.builder(
                            itemCount: _searchList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: .78,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return ChangeNotifierProvider.value(
                                value: _searchList[index],
                                child: const ProductWidget(),
                              );
                            },
                          );
                        }
                      }
                      return const Center(
                        child: Text('No Connections Found!',
                            style: TextStyle(fontSize: 20)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
     
     */


//// for examle
/*
                                        if () {
                                          if ((i.productprice! >=
                                                  double.parse(
                                                      minController.text) &&
                                              i.productprice! <=
                                                  double.parse(
                                                      maxController.text))) {
                                            // _filterList.add(i);
                                            searchController.filterAddProduct(
                                                productModel: i);

                                            // setState(() {
                                            //   _filterList;
                                            //   _isfilter = true;
                                            // });
                                          }
                                        } else {
                                          if ((i.productprice! >= min &&
                                                  i.productprice! <= max) &&
                                              i.productcategory!.contains(
                                                  categoryController
                                                      .getCategory)) {
                                            searchController.filterAddProduct(
                                                productModel: i);
                                            // _filterList.add(i);
                                            // setState(() {
                                            //   _filterList;
                                            //   _isfilter = true;
                                            // });
                                          }
                                        }
                                      */