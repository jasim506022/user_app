import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../res/routes/routesname.dart';
import '../../res/cartmethod.dart';
import '../../res/gobalcolor.dart';
import '../../res/textstyle.dart';
import '../../res/utils.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/cart_product_counter_provider.dart';
import '../../res/constants.dart';
import '../../model/productsmodel.dart';
import '../../widget/cart_badge.dart';
import '../../widget/single_empty_widget.dart';
import '../cart/cartpage.dart';
import 'details_card_swiper.dart';
import 'loading_similar_widet.dart';
import 'similar_product_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isCart = false;
  int countNumber = 1;

  List<String> productIdListFromCartLish =
      CartMethods.separeteProductIdUserCartList();

  @override
  void initState() {
    if (productIdListFromCartLish.contains(widget.productModel.productId)) {
      isCart = true;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Utils utils = Utils(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: utils.green300,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    Utils utils = Utils(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // Understand All  Push and Pop
        Navigator.pushReplacementNamed(context, RoutesName.mainPage,
            arguments: 0);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => MainPage(index: 0),
        //     ));

        // return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: _buildAddCartItemFlotatActionButton(textstyle),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 418,
                width: mq.width,
                child: Stack(
                  children: [
                    //understand this code carefully
                    for (Map<String, dynamic> circleConfig in [
                      {
                        'left': -200.00,
                        'right': -200.00,
                        'top': -400.00,
                        'size': 800.00,
                        'color': utils.green100
                      },
                      {
                        'left': -80.00,
                        'right': -80.00,
                        'top': -300.00,
                        'size': 600.00,
                        'color': utils.green200
                      },
                      {
                        'left': 0.00,
                        'right': 0.00,
                        'top': -mq.width * 0.425,
                        'size': mq.width * 0.85,
                        'color': utils.green300
                      },
                    ])
                      Positioned(
                        left: circleConfig['left'],
                        right: circleConfig['right'],
                        top: circleConfig['top'],
                        child: Container(
                          height: circleConfig['size'],
                          width: circleConfig['size'],
                          decoration: BoxDecoration(
                            color: circleConfig['color'],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    /*
                    Positioned(
                      left: -200,
                      right: -200,
                      top: -400,
                      child: Container(
                        height: 800,
                        width: 800,
                        decoration: BoxDecoration(
                            color: utils.green100, shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      left: -80,
                      right: -80,
                      top: -300,
                      child: Container(
                        height: 600,
                        width: 600,
                        decoration: BoxDecoration(
                            color: utils.green200, shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: -mq.width * .425,
                      child: Container(
                        height: mq.width * .85,
                        width: mq.width * .85,
                        decoration: BoxDecoration(
                            color: utils.green300, shape: BoxShape.circle),
                      ),
                    ),
                   */
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.mainPage,
                                        arguments: 0);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: greenColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.cartPage);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           const CartPage(),
                                    //     ));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: greenColor,
                                        shape: BoxShape.circle),
                                    child: Consumer<CartProductCountProvider>(
                                      builder: (context, value, child) {
                                        return CartBadge(
                                          color: white,
                                          itemCount: value.getCount,
                                          icon: Icons.shopping_cart,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            DetailsSwiperWidget(
                                productModel: widget.productModel),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.productModel.productname!,
                        style: textstyle.largestText.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          letterSpacing: 1.2,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "৳. ${globalMethod.productPrice(widget.productModel.productprice!, widget.productModel.discount!.toDouble())}",
                          style: GoogleFonts.abrilFatface(
                              color: greenColor,
                              fontSize: 16,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${widget.productModel.productunit}",
                          style: GoogleFonts.abrilFatface(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Text(
                          "Discount: ${(widget.productModel.discount!)}%",
                          style: GoogleFonts.poppins(
                              color: red,
                              letterSpacing: 1.2,
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "${(widget.productModel.productprice!)}",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.lineThrough,
                              color: red,
                              letterSpacing: 1.2,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.productModel.productdescription!,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "৳. ${globalMethod.productPrice(widget.productModel.productprice!, widget.productModel.discount!.toDouble())}",
                          style: textstyle.largeText.copyWith(
                            color: greenColor,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Row(
                          children: [
                            //Increament Button
                            _buildIncreandDecrementButton(
                              () {
                                countNumber++;
                                setState(() {});
                              },
                              Icons.add,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(countNumber.toString(),
                                  style: textstyle.largestText),
                            ),

                            //Increament Button
                            _buildIncreandDecrementButton(
                              () {
                                if (countNumber == 1) {
                                  globalMethod.flutterToast(
                                      msg:
                                          "The Quantity cannot be less then 1");
                                } else {
                                  countNumber--;
                                  setState(() {});
                                }
                              },
                              Icons.remove,
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     if (countNumber == 1) {
                            //       globalMethod.flutterToast(
                            //           msg:
                            //               "The Quantity cannot be less then 1");
                            //     } else {
                            //       countNumber--;
                            //       setState(() {});
                            //     }
                            //   },
                            //   child: Container(
                            //     padding: const EdgeInsets.all(5),
                            //     decoration: BoxDecoration(
                            //         color: greenColor,
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: Icon(
                            //       Icons.remove,
                            //       color: white,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const Spacer(),
                        // Rattting Product
                        Row(
                          children: [
                            Icon(Icons.star, color: yellow),
                            RichText(
                              text: TextSpan(
                                  style: textstyle.mediumText600.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    const TextSpan(text: "( "),
                                    TextSpan(
                                        text:
                                            "${widget.productModel.productrating!}"),
                                    TextSpan(
                                      text: " Rattings ",
                                      style: GoogleFonts.poppins(
                                        color: Theme.of(context).hintColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const TextSpan(text: ")"),
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Similar Products",
                      style: GoogleFonts.abrilFatface(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildSimilarProjectList(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// Similar Project List
  SizedBox _buildSimilarProjectList() {
    return SizedBox(
      height: 150,
      width: mq.width,
      child: StreamBuilder(
        stream: FirebaseDatabase.similarProductSnapshot(
            productModel: widget.productModel),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingSimilierWidget();
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
          }
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length > 5
                    ? 5
                    : snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  ProductModel models =
                      ProductModel.fromMap(snapshot.data!.docs[index].data());
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(
                              productModel: models,
                            ),
                          ));
                    },
                    child: SimilarProductWidget(models: models),
                  );
                });
          }
          return const LoadingSimilierWidget();
        },
      ),
    );
  }

// Increment and Decrement Buttton
  InkWell _buildIncreandDecrementButton(VoidCallback function, IconData icon) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: greenColor, borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: white,
        ),
      ),
    );
  }

  // Add item on cart function
  FloatingActionButton _buildAddCartItemFlotatActionButton(
      Textstyle textstyle) {
    //extended us for icon and text
    return FloatingActionButton.extended(
      backgroundColor: isCart ? red : greenColor,
      onPressed: () {
        List<String> cartItemIdList =
            CartMethods.separeteProductIdUserCartList();

        if (cartItemIdList.contains(widget.productModel.productId)) {
          globalMethod.flutterToast(msg: "Item is already  in cart");
        } else {
          CartMethods.addItemToCartWithSeller(
              productId: widget.productModel.productId!,
              productCounter: countNumber,
              seller: widget.productModel.sellerId!,
              context: context);
          isCart = true;
          setState(() {});
        }
      },
      icon: Icon(
        Icons.shopping_cart,
        color: white,
      ),
      label: Text(
        isCart ? "Item Already in Cart" : "Add To Cart",
        style: textstyle.smallText.copyWith(color: white),
      ),
    );
  }
}
