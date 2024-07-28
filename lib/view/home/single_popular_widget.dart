import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/routesname.dart';

import '../../controller/product_controller.dart';
import '../../res/app_function.dart';
import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../model/productsmodel.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);

    var productController = Get.put(ProductController(
      Get.find(),
    ));

    productController.checkIfInCart(productModel: productModel);

    return InkWell(
      onTap: () {
        Get.toNamed(RoutesName.productDestailsPage, arguments: productModel);

        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ProductDetailsPage(
        //         productModel: productModel,
        //       ),
        //     ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Container(
          height: mq.height * .17,
          width: mq.width * .8,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.black,
                  spreadRadius: .05,
                )
              ],
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: mq.height * .145,
                    width: mq.height * .145,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.cardImageBg,
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: 120,
                        boxFit: BoxFit.contain,
                        imageUrl: productModel.productimage![0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.red, width: .5),
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.lightred.withOpacity(.2),
                      ),
                      child: Text("${productModel.discount}% Off",
                          style: Textstyle.mediumText600),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 12, top: 15, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "৳. ${AppsFunction.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                            style: Textstyle.largeText
                                .copyWith(color: AppColors.red),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            "${(productModel.productprice!)}",
                            style: Textstyle.mediumText400lineThrough,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: productModel.productname!,
                            style: Textstyle.largeText,
                          ),
                          TextSpan(
                            text: "(${productModel.productunit!})",
                            style: Textstyle.smallestText,
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: mq.height * .045,
                        width: mq.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: productController.isCart.value
                              ? AppColors.red
                              : AppColors.greenColor,
                        ),
                        child: Text(
                          "Add To Cart",
                          style: Textstyle.largeText
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
