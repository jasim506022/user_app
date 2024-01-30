import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/productsmodel.dart';
import 'detailsproductpage.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
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
      child: Card(
        child: Container(
          height: mq.height,
          width: mq.width,
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: white,
                  spreadRadius: .08,
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: mqs(context).height * .125,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: cardImageBg,
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FancyShimmerImage(
                        height: mqs(context).height * .85,
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
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "৳. ${(productModel.productprice!) - (productModel.productprice! * productModel.discount! / 100)}",
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
                        height: 2,
                      ),
                      FittedBox(
                        child: Text(
                          productModel.productname!,
                          style: textstyle.largeText,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                      productModel: productModel),
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: mqs(context).height * .045,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isCart ? red : greenColor,
                            ),
                            child: Text(
                              "Add To Cart",
                              style: textstyle.largeText
                                  .copyWith(color: white, fontSize: 14),
                            ),
                          )),
                      const SizedBox(
                        height: 7,
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
