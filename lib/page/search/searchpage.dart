import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_app/widget/empty_widget.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../model/productsmodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/category_provider.dart';
import '../../widget/product_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductModel> _list = [];

  // for storing searched items
  final List<ProductModel> _searchList = [];
  final List<ProductModel> _filterList = [];

//
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  // for storing search status
  bool _isfilter = false;
  bool _isSearchList = false;

  double min = 0;
  double max = 1000.00;

  @override
  void initState() {
    minController.text = min.toString();
    maxController.text = max.toString();
    super.initState();
  }

  //Future<QuerySnapshot>? storesDocumentList;

  // initailizeSearchingProduct(String textEntereByUser) {
  //   storesDocumentList = FirebaseFirestore.instance
  //       .collection("products")
  //       .where("productname", isGreaterThanOrEqualTo: textEntereByUser)
  //       .get();
  // }

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
                                      color: greenColor,
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
                                          color: black,
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
                                            style: TextStyle(color: black),
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
                                            style: TextStyle(color: black),
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
                                          color: black,
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
                                        backgroundColor: greenColor,
                                        padding: const EdgeInsets.all(5)),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Close',
                                      style: GoogleFonts.roboto(
                                          color: white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Consumer<CategoryProvider>(
                                    builder: (context, value, child) {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: greenColor,
                                            padding: const EdgeInsets.all(5)),
                                        onPressed: () {
                                          _filterList.clear();
                                          for (var i in _list) {
                                            if (value.getCategory
                                                    .toLowerCase() ==
                                                "All".toLowerCase()) {
                                              if ((i.productprice! >=
                                                      double.parse(
                                                          minController.text) &&
                                                  i.productprice! <=
                                                      double.parse(maxController
                                                          .text))) {
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
                                                      value.getCategory)) {
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
                                                color: white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500)),
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(
                          FontAwesomeIcons.sliders,
                          color: greenColor,
                        ))
                  ],
                ),
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
                              itemCount: _isSearchList
                                  ? _searchList.length
                                  : _filterList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: .78,
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

                        return const EmptyWidget(
                            image: "asset/payment/emptytow.png",
                            title: "Now Data Found");
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    return Consumer<CategoryProvider>(
      builder: (context, dropvaluesall, child) {
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
          value: dropvaluesall.getCategory,
          isExpanded: true,
          style: GoogleFonts.poppins(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w700),
          focusColor: Colors.black,
          elevation: 16,
          items: allCategoryList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) {
            Provider.of<CategoryProvider>(context, listen: false)
                .setCategory(category: value!);
          },
        );
      },
    );
  }
}

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
