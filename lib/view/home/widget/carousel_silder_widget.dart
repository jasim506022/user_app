import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../model/carsole_model.dart';
import 'carosuel_widget.dart';

class CarouselSilderWidget extends StatelessWidget {
  const CarouselSilderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: .22.sh,
          aspectRatio: 16 / 12,
          viewportFraction: 0.9,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(seconds: 3)),
      items: caroselList.map((carouselModel) {
        return Builder(
          builder: (BuildContext context) {
            return CarouselWidget(
              carouselModel: carouselModel,
            );
          },
        );
      }).toList(),
    );
  }
}
