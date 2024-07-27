import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../res/app_colors.dart';
import '../../model/productsmodel.dart';

class DetailsSwiperWidget extends StatelessWidget {
  const DetailsSwiperWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 300,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: productModel.productimage![index],
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child:
                    CircularProgressIndicator(value: downloadProgress.progress),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
          autoplay: productModel.productimage!.length == 1 ? false : true,
          itemCount: productModel.productimage!.length,
          pagination: SwiperPagination(
              alignment: Alignment.bottomCenter,
              builder:
                  DotSwiperPaginationBuilder(color:AppColors. white, activeColor:AppColors. red)),
          control: const SwiperControl(color: Colors.transparent),
        ),
      ),
    );
  }
}
