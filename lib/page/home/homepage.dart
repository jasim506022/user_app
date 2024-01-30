import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_app/const/approutes.dart';
import '../../service/provider/cartprovider.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/productsmodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/category_provider.dart';
import '../../widget/cart_badge.dart';
import '../../widget/empty_widget.dart';
import '../../widget/single_empty_widget.dart';
import '../../widget/loading_product_widget.dart';
import '../../widget/single_loading_product_widget.dart';
import '../product/product_widget.dart';
import '../product/productpage.dart';
import 'carousel_silder_widget.dart';
import 'category_widget.dart';
import 'row_widget.dart';
import 'single_popular_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<CategoryProvider>(context, listen: false)
        ..setCategory(category: allCategoryList.first)
        ..setIndex(index: 0);
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * .03, vertical: mq.height * .034),
          child: Column(
            children: [
              Column(
                children: [
                  // user Profile
                  _buildUserProfile(textstyle),
                  SizedBox(height: mq.height * .015),
                  // Search
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouters.searchPage);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => const SearchPage(),
                      //     ));
                    },
                    child: _buildSearchBar(),
                  ),
                ],
              ),
              Expanded(
                child: Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          // Carousel Silder Widget
                          SizedBox(
                            height: mq.height * .25,
                            width: mq.width,
                            child: const CarouselSilderWidget(),
                          ),
                          SizedBox(height: mq.height * .013),
                          // Select Category
                          const CategoryWidget(),
                          SizedBox(height: mq.height * .02),

                          RowWidget(
                            text: "Popular Product",
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductPage(isPopular: true),
                                  ));
                            },
                          ),
                          SizedBox(height: mq.height * .01),
                          // Popular Product List
                          _buildPopularProductList(categoryProvider),
                          SizedBox(
                            height: mq.height * .012,
                          ),

                          RowWidget(
                            text: "Product",
                            function: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProductPage(),
                                  ));
                            },
                          ),
                          // Product List
                          _buildProductList(categoryProvider)
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }

//Product List
  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _buildProductList(
      CategoryProvider categoryProvider) {
    return StreamBuilder(
      stream: FirebaseDatabase.productSnapshots(
          category: categoryProvider.getCategory),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingProductWidget();
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                snapshot.data!.docs.length > 8 ? 8 : snapshot.data!.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .78,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20),
            itemBuilder: (context, index) {
              ProductModel productModel =
                  ProductModel.fromMap(snapshot.data!.docs[index].data());
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
  }

// Popular Porduct List
  SizedBox _buildPopularProductList(CategoryProvider categoryProvider) {
    return SizedBox(
      height: mq.height * .19,
      width: double.infinity,
      child: StreamBuilder(
        stream: FirebaseDatabase.popularProductSnapshot(
            category: categoryProvider.getCategory),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const LoadingSingleProductWidget();
              },
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const SingleEmptyWidget(
              image: 'asset/payment/emptytow.png',
              title: 'No Data Available',
            );
          } else if (snapshot.hasError) {
            return SingleEmptyWidget(
              image: 'asset/payment/emptytow.png',
              title: 'Error Occure: ${snapshot.error}',
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length > 5
                  ? 5
                  : snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                ProductModel productModel =
                    ProductModel.fromMap(snapshot.data!.docs[index].data());
                return ChangeNotifierProvider.value(
                  value: productModel,
                  child: const SingleProductWidget(),
                );
              },
            );
          } else {
            return const SingleEmptyWidget(
              image: 'asset/payment/emptytow.png',
              title: 'No Data Available',
            );
          }
        },
      ),
    );
  }

  //Profile
  SizedBox _buildUserProfile(Textstyle textstyle) {
    return SizedBox(
      height: mq.height * .08,
      width: mq.width,
      child: Row(
        children: [
          Container(
            height: mq.height * .08,
            width: mq.height * .08,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: red, width: 3)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(mq.height * 0.04),
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(
                  backgroundColor: white,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: sharedPreference!.getString("imageurl") ??
                    "asset/empty/blank.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: mq.width * .03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi!",
                  style: textstyle.largestText.copyWith(color: greenColor)),
              Text(
                sharedPreference!.getString("name") ?? "Jasim Uddin",
                style: textstyle.largeText,
              )
            ],
          ),
          const Spacer(),
          Consumer<CartProductCounter>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AppRouters.cartPage);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => const CartPage(),
                  //     ));
                },
                child: CartBadge(
                    color: greenColor,
                    itemCount: value.getCount,
                    icon: Icons.shopping_bag),
              );
            },
          ),
          SizedBox(
            width: mq.width * .02,
          ),
        ],
      ),
    );
  }

  // Search
  Container _buildSearchBar() {
    return Container(
      height: mq.height * .065,
      margin: EdgeInsets.symmetric(vertical: mq.height * .02),
      width: mq.width,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.only(left: mq.width * .07),
        child: Row(
          children: [
            Text(
              "Search...........",
              style: GoogleFonts.roboto(
                color: Theme.of(context).hintColor,
                fontSize: 15,
              ),
            ),
            const Spacer(),
            Icon(
              IconlyLight.search,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              width: mq.width * 0.022,
            ),
          ],
        ),
      ),
    );
  }
}
