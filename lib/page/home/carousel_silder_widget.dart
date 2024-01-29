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
      items: caroselList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: mq.width,
                padding: const EdgeInsets.only(left: 25, bottom: 15, top: 15),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                    color: i.color, borderRadius: BorderRadius.circular(15)),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        i.image,
                        height: mqs(context).height * .19,
                        width: mqs(context).height * .19,
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
                                  text: " ${i.category}",
                                  style: textstyle.mediumTextbold.copyWith(
                                    letterSpacing: .9,
                                    color: greenColor,
                                  )),
                            ],
                          ),
                        ),
                        Text(
                          i.title,
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
                              i.number.toUpperCase(),
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
