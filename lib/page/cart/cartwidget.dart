import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../model/productsmodel.dart';
import '../product/detailsproductpage.dart';
import 'dotlineprinter.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    super.key,
    required this.productModel,
    required this.itemQunter,
    required this.index,
  });
  final ProductModel productModel;
  final int itemQunter;
  final int index;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                productModel: widget.productModel,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width * .9,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 110,
                        width: 140,
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
                            imageUrl: widget.productModel.productimage![0],
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
                          child: Text(
                            "${widget.productModel.discount}% Off",
                            style: GoogleFonts.poppins(
                              color: red,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                flex: 4,
                                child: FittedBox(
                                  child: Text(
                                    widget.productModel.productname!,
                                    style: GoogleFonts.poppins(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Flexible(
                                flex: 1,
                                child: InkWell(
                                  onTap: () async {
                                    CartMethods.removeProdctFromCart(
                                        index: widget.index, context: context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: red, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Icon(
                                      Icons.remove,
                                      color: red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.productModel.productunit!.toString(),
                                style: GoogleFonts.poppins(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${1 * widget.itemQunter} * ",
                                    style: GoogleFonts.poppins(
                                        color: greenColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${globalMethod.productPrice(widget.productModel.productprice!, widget.productModel.discount!.toDouble())}",
                                    style: GoogleFonts.poppins(
                                        color: greenColor,
                                        fontSize: 14,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                "= ৳. ${globalMethod.productPrice(widget.productModel.productprice!, widget.productModel.discount!.toDouble()) * widget.itemQunter}",
                                style: GoogleFonts.poppins(
                                    color: greenColor,
                                    fontSize: 16,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: MediaQuery.of(context)
                  .size
                  .width, // Adjust the width as needed
              child: CustomPaint(
                painter: DottedLinePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
