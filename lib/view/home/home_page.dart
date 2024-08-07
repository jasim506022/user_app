import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/controller/product_controller.dart';
import 'package:user_app/res/constant/string_constant.dart';
import 'package:user_app/view/home/popular_product_list_widget.dart';



import '../../res/routes/routesname.dart';

import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';

import '../../service/provider/cart_product_counter_provider.dart';
import '../../widget/cart_badge.dart';


import '../product/product_list_widget.dart';
import 'carousel_silder_widget.dart';
import 'category_widget.dart';
import 'row_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var productController = Get.put(ProductController(
    Get.find(),
  ));
  var cartProductCountController = Get.put(CartProductCountController());

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
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(
        
                horizontal: Get.width * .03),
            child: Column(
              children: [
                // Header
                Column(
                  children: [
                    // user Profile
                    _buildUserProfile(),

                    SizedBox(
                   
                      height: Get.height * .015,
                    ),
                    // Search
                    InkWell(
                      onTap: () {
                        Get.toNamed(RoutesName.searchPage);
                      },
                      child: _buildSearchBar(),
                    ),
                  ],
                ),

                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .25,
                        width: Get.width,
                        child: const CarouselSilderWidget(),
                      ),
                      SizedBox(height: Get.height * .013),
                      const CategoryWidget(),
                      SizedBox(height: Get.height * .02),
                      RowWidget(
                        text: "Popular Product",
                        function: () {
                          Get.toNamed(RoutesName.productPage, arguments: true);
                        },
                      ),
                      SizedBox(height: Get.height * .01),
                      // _buildPopularProductList(),
                      const PopularProductListWidget(),
                      SizedBox(
                        height: Get.height * .012,
                      ),
                      RowWidget(
                        text: "Product",
                        function: () {
                          Get.toNamed(RoutesName.productPage, arguments: false);
                        },
                      ),
                      const ProductListWidget(
                        isScroll: false,
                      )
                    ],
                  ),
                )),
              ],
            )),
      ),
    );
  }



  //Profile User
  SizedBox _buildUserProfile() {
    String? imageUrl =
        sharedPreference?.getString(StringConstant.imageSharedPreference);
    String? name =
        sharedPreference?.getString(StringConstant.nameSharedPreference);

    return SizedBox(
      height: Get.height * .08,
      width: Get.width,
      child: Row(
        children: [
          // User Profile Image
          Container(
            height: Get.height * .08,
            width: Get.height * .08,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.red, width: 3)),
            child: ClipOval(
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(
                  backgroundColor: AppColors.white,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: imageUrl!,
                fit: BoxFit.fill,
              ),
            ),
          ),

          SizedBox(
            width: Get.width * .03,
          ),

          // User Informatiokn
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi!",
                  style: Textstyle.largestText
                      .copyWith(color: AppColors.greenColor)),
              Text(
                name!,
                style: Textstyle.largeText,
              )
            ],
          ),
          const Spacer(),

          InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesName.cartPage);
              },
              child: Obx(
                () => CartBadge(
                    color: AppColors.greenColor,
                    itemCount: cartProductCountController.getCounts,
                    icon: Icons.shopping_bag),
              )),
          SizedBox(
            width: Get.width * .02,
          ),
        ],
      ),
    );
  }

  // Search
  Container _buildSearchBar() {
    return Container(
      height: Get.height * .065,
      margin: EdgeInsets.symmetric(vertical: Get.height * .02),
      width: Get.width,
      decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.only(left: Get.width * .07),
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
              width: Get.width * 0.022,
            ),
          ],
        ),
      ),
    );
  }
}

