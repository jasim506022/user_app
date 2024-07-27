import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/productsmodel.dart';

class SimilarProductWidget extends StatelessWidget {
  const SimilarProductWidget({
    super.key,
    required this.models,
  });

  final ProductModel models;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 100,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 15),
      color: Theme.of(context).cardColor,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FancyShimmerImage(
              height: 100,
              boxFit: BoxFit.fill,
              imageUrl: models.productimage![0],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            child: Text(
              models.productname!,
              textAlign: TextAlign.justify,
              style: GoogleFonts.poppins(
                  color: Theme.of(context).primaryColor,
                  fontSize: 13,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
