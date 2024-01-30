import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/carsolemodel.dart';

class CarouselSilderWidget extends StatelessWidget {
  const CarouselSilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    return CarouselSlider(
      options: CarouselOptions(
          height: mq.height * .22,
          aspectRatio: 16 / 12,
          viewportFraction: 0.9,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 3)),
      // What is call is Map Name
      // Understand This code
      items: caroselList.map((carosle) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: mq.width,
                padding: EdgeInsets.only(
                    left: mq.width * .055,
                    bottom: mq.height * .02,
                    top: mq.height * .02),
                margin: EdgeInsets.symmetric(horizontal: mq.width * .022),
                decoration: BoxDecoration(
                    color: carosle.color,
                    borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        carosle.image,
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
                                style: textstyle.mediumText600.copyWith(
                                  letterSpacing: .9,
                                  color: Colors.black87,
                                ),
                              ),
                              TextSpan(
                                  text: " ${carosle.category}",
                                  style: textstyle.mediumTextbold.copyWith(
                                    letterSpacing: .9,
                                    color: greenColor,
                                  )),
                            ],
                          ),
                        ),
                        Text(
                          carosle.title,
                          style: textstyle.largestText
                              .copyWith(fontSize: 24, color: black),
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: greenColor, shape: BoxShape.circle),
                              child: Icon(
                                Icons.done,
                                color: black,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              carosle.number.toUpperCase(),
                              style: textstyle.largeBoldText.copyWith(
                                letterSpacing: 1,
                                color: greenColor,
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("Shop Now",
                              style: textstyle.largeBoldText.copyWith(
                                color: black,
                                fontSize: 15,
                                letterSpacing: 1,
                              )),
                        )
                      ],
                    ),
                  ],
                ));
          },
        );
      }).toList(),
    );
  }
}
