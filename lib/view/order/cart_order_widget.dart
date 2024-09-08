import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../res/app_function.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import '../../model/productsmodel.dart';
import 'deliverypage.dart';

class CartOrderWidget extends StatelessWidget {
  const CartOrderWidget(
      {super.key,
      required this.itemCount,
      required this.data,
      required this.orderId,
      required this.seperateQuantilies});

  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderId;
  final List<int> seperateQuantilies;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeliveryScreen(
                orderId: orderId,
                seperateQuantilies: seperateQuantilies,
              ),
            ));
      },
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        shadowColor: AppColors.black,
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: itemCount * 120,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              ProductModel model = ProductModel.fromMap(
                  data[index].data() as Map<String, dynamic>);
              return Container(
                height: 110,
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
                          height: 95,
                          width: 80, //140
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
                              imageUrl: model.productimage![0],
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
                              border:
                                  Border.all(color: AppColors.red, width: .5),
                              borderRadius: BorderRadius.circular(15),
                              color: AppColors.lightred.withOpacity(.2),
                            ),
                            child: Text(
                              "${model.discount}% Off",
                              style: GoogleFonts.poppins(
                                color: AppColors.red,
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
                            FittedBox(
                              child: Text(
                                model.productname!,
                                style: Textstyle.largestText
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(model.productunit!.toString(),
                                    style: Textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).hintColor,
                                    )),
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
                                    Text("${seperateQuantilies[index]} * ",
                                        style: Textstyle.mediumText600.copyWith(
                                            color: AppColors.greenColor)),
                                    Text(
                                        "${AppsFunction.productPrice(model.productprice!, model.discount!.toDouble())}",
                                        style: Textstyle.mediumText600.copyWith(
                                            letterSpacing: 1.2,
                                            color: AppColors.greenColor)),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                    "= ৳. ${AppsFunction.productPrice(model.productprice!, model.discount!.toDouble()) * seperateQuantilies[index]}",
                                    style: Textstyle.mediumTextbold.copyWith(
                                      color: AppColors.greenColor,
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
