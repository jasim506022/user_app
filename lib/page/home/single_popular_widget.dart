import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/productsmodel.dart';
import '../product/detailsproductpage.dart';

class SingleProductWidget extends StatelessWidget {
  const SingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductModel>(context);
    Textstyle textstyle = Textstyle(context);
    bool isCart = false;
    List<String> productIdListFromCartLish =
        CartMethods.separeteProductIdUserCartList();
    if (productIdListFromCartLish.contains(productModel.productId)) {
      isCart = true;
    }
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productModel: productModel,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Container(
          height: mqs(context).height * .17,
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: black,
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
                    height: mqs(context).height * .145,
                    width: mqs(context).height * .145,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: cardImageBg,
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
                        border: Border.all(color: red, width: .5),
                        borderRadius: BorderRadius.circular(15),
                        color: lightred.withOpacity(.2),
                      ),
                      child: Text("${productModel.discount}% Off",
                          style: textstyle.mediumText600),
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
                            "৳. ${globalMethod.productPrice(productModel.productprice!, productModel.discount!.toDouble())}",
                            style: textstyle.largeText.copyWith(color: red),
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
                            style: textstyle.largeText,
                          ),
                          TextSpan(
                            text: "(${productModel.productunit!})",
                            style: textstyle.smallestText,
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: mqs(context).height * .045,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: isCart ? red : greenColor,
                        ),
                        child: Text(
                          "Add To Cart",
                          style: textstyle.largeText.copyWith(color: white),
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
