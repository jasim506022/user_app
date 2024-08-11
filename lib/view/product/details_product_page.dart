import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/controller/product_controller.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/view/product/similar_product_list.dart';
import '../../res/routes/routesname.dart';
import '../../res/cartmethod.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../res/utils.dart';
import '../../service/provider/cart_product_counter_provider.dart';
import '../../res/constants.dart';
import '../../model/productsmodel.dart';
import '../../widget/cart_badge.dart';
import 'details_card_swiper.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductModel? productModel;

  bool isCart = false;

  int counter = 1;

  List<String> productIdListFromCartLish =
      CartMethods.separeteProductIdUserCartList();

  var cartProductCountController = Get.put(CartProductCountController());
  var productController = Get.put(ProductController(Get.find()));

  @override
  void initState() {
    productModel = Get.arguments;

    if (productIdListFromCartLish.contains(productModel!.productId)) {
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
    Utils utils = Utils(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // Understand All  Push and Pop
        // Navigator.pushReplacementNamed(context, RoutesName.mainPage,
        //     arguments: 0);
        // understand this Code
        Get.offAndToNamed(RoutesName.mainPage);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => MainPage(index: 0),
        //     ));

        // return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        floatingActionButton: _buildAddCartItemFlotatActionButton(),
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
                                    Get.toNamed(RoutesName.mainPage);
                                    // Navigator.pushNamed(
                                    //     context, RoutesName.mainPage,
                                    //     arguments: 0);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: AppColors.greenColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(RoutesName.cartPage);
                                  },
                                  child: Obx(
                                    () => Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: AppColors.greenColor,
                                          shape: BoxShape.circle),
                                      child: CartBadge(
                                        color: AppColors.white,
                                        itemCount: cartProductCountController
                                            .getCounts,
                                        icon: Icons.shopping_cart,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            DetailsSwiperWidget(productModel: productModel!),
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
                    Text(productModel!.productname!,
                        style: Textstyle.largestText.copyWith(
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
                          "৳. ${AppsFunction.productPrice(productModel!.productprice!, productModel!.discount!.toDouble())}",
                          style: GoogleFonts.abrilFatface(
                              color: AppColors.greenColor,
                              fontSize: 16,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${productModel!.productunit}",
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
                          "Discount: ${(productModel!.discount!)}%",
                          style: GoogleFonts.poppins(
                              color: AppColors.red,
                              letterSpacing: 1.2,
                              fontSize: 16,
                              fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "${(productModel!.productprice!)}",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.lineThrough,
                              color: AppColors.red,
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
                      productModel!.productdescription!,
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
                          "৳. ${AppsFunction.productPriceWithQuantity(productModel!.productprice!, productModel!.discount!.toDouble(), counter).toStringAsFixed(2)}",
                          style: Textstyle.largeText.copyWith(
                            color: AppColors.greenColor,
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
                                counter++;
                                setState(() {});
                              },
                              Icons.add,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(counter.toString(),
                                  style: Textstyle.largestText),
                            ),

                            //Increament Button
                            _buildIncreandDecrementButton(
                              () {
                                if (counter == 1) {
                                  AppsFunction.flutterToast(
                                      msg:
                                          "The Quantity cannot be less then 1");
                                } else {
                                  counter--;
                                  setState(() {});
                                }
                              },
                              Icons.remove,
                            ),
                          ],
                        ),

                        const Spacer(),
                        // Rattting Product
                        Row(
                          children: [
                            Icon(Icons.star, color: AppColors.yellow),
                            RichText(
                              text: TextSpan(
                                  style: Textstyle.mediumText600.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                  children: [
                                    const TextSpan(text: "( "),
                                    TextSpan(
                                        text:
                                            "${productModel!.productrating!}"),
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
                    // _buildSimilarProjectList(),
                    SimilarProductList(productModel: productModel),
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

// Increment and Decrement Buttton
  InkWell _buildIncreandDecrementButton(VoidCallback function, IconData icon) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: AppColors.white,
        ),
      ),
    );
  }

  // Add item on cart function
  FloatingActionButton _buildAddCartItemFlotatActionButton() {
    //extended us for icon and text
    return FloatingActionButton.extended(
      backgroundColor: isCart ? AppColors.red : AppColors.greenColor,
      onPressed: () {
        if (kDebugMode) {
          print(counter);
        }
        List<String> cartItemIdList =
            CartMethods.separeteProductIdUserCartList();

        if (cartItemIdList.contains(productModel!.productId)) {
          AppsFunction.flutterToast(msg: "Item is already  in cart");
        } else {
          CartMethods.addItemToCartWithSeller(
              productId: productModel!.productId!,
              productCounter: counter,
              seller: productModel!.sellerId!,
              context: context);
          isCart = true;
          setState(() {});
        }
      },
      icon: Icon(
        Icons.shopping_cart,
        color: AppColors.white,
      ),
      label: Text(
        isCart ? "Item Already in Cart" : "Add To Cart",
        style: Textstyle.smallText.copyWith(color: AppColors.white),
      ),
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../res/routes/routesname.dart';
import '../../res/cartmethod.dart';
import '../../res/gobalcolor.dart';
import '../../res/Textstyle.dart';
import '../../res/utils.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/cart_product_counter_provider.dart';
import '../../res/constants.dart';
import '../../model/productsmodel.dart';
import '../../widget/cart_badge.dart';
import '../../widget/single_empty_widget.dart';
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
    Textstyle Textstyle = Textstyle(context);
    Utils utils = Utils(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // Understand All  Push and Pop
        // Navigator.pushReplacementNamed(context, RoutesName.mainPage,
        //     arguments: 0);
        Get.offAndToNamed(RoutesName.mainPage);
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => MainPage(index: 0),
        //     ));

        // return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          floatingActionButton: _buildAddCartItemFlotatActionButton(Textstyle),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RoutesName.mainPage);
                                      // Navigator.pushNamed(
                                      //     context, RoutesName.mainPage,
                                      //     arguments: 0);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppColors.greenColor,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: AppColors.white,
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
                                          color: AppColors.greenColor,
                                          shape: BoxShape.circle),
                                      child: Consumer<CartProductCountProvider>(
                                        builder: (context, value, child) {
                                          return CartBadge(
                                            color: AppColors.white,
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
                          style: Textstyle.largestText.copyWith(
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
                                color: AppColors.greenColor,
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
                                color: AppColors.red,
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
                                color: AppColors.red,
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
                            style: Textstyle.largeText.copyWith(
                              color: AppColors.greenColor,
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
                                    style: Textstyle.largestText),
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
                              Icon(Icons.star, color: AppColors.yellow),
                              RichText(
                                text: TextSpan(
                                    style: Textstyle.mediumText600.copyWith(
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
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(10)),
        child: Icon(
          icon,
          color: AppColors.white,
        ),
      ),
    );
  }

  // Add item on cart function
  FloatingActionButton _buildAddCartItemFlotatActionButton(
      Textstyle Textstyle) {
    //extended us for icon and text
    return FloatingActionButton.extended(
      backgroundColor: isCart ? AppColors.red : AppColors.greenColor,
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
        color: AppColors.white,
      ),
      label: Text(
        isCart ? "Item Already in Cart" : "Add To Cart",
        style: Textstyle.smallText.copyWith(color: AppColors.white),
      ),
    );
  }
}
*/
