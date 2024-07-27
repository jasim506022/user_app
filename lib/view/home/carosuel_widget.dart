

import 'package:flutter/material.dart';

import '../../model/carsolemodel.dart';
import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    super.key,
    required this.carouselModel,
  });

  final CarouselModel carouselModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: mq.width,
        padding: EdgeInsets.only(
            left: mq.width * .055,
            bottom: mq.height * .02,
            top: mq.height * .02),
        margin: EdgeInsets.symmetric(horizontal: mq.width * .022),
        decoration: BoxDecoration(
            color: carouselModel.color, borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                carouselModel.image,
                height: mq.height * .19,
                width: mq.height * .19,
                fit: BoxFit.contain,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Cold Process",
                        style: Textstyle.mediumText600.copyWith(
                          letterSpacing: .9,
                          color: Colors.black87,
                        ),
                      ),
                      TextSpan(
                          text: " ${carouselModel.category}",
                          style: Textstyle.mediumTextbold.copyWith(
                            letterSpacing: .9,
                            color: AppColors.greenColor,
                          )),
                    ],
                  ),
                ),
                Text(
                  carouselModel.title,
                  style: Textstyle.largestText
                      .copyWith(fontSize: 24, color: AppColors.black),
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.greenColor, shape: BoxShape.circle),
                      child: Icon(
                        Icons.done,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      carouselModel.number.toUpperCase(),
                      style: Textstyle.largeBoldText.copyWith(
                        letterSpacing: 1,
                        color: AppColors.greenColor,
                      ),
                    )
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text("Shop Now",
                      style: Textstyle.largeBoldText.copyWith(
                        color: AppColors.black,
                        fontSize: 15,
                        letterSpacing: 1,
                      )),
                )
              ],
            ),
          ],
        ));
  }
}
