import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:user_app/const/utils.dart';

class LoadingAddressWidget extends StatelessWidget {
  const LoadingAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Container(
      alignment: Alignment.center,
      height: 120,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: BoxDecoration(
          color: utils.green50, borderRadius: BorderRadius.circular(25)),
      child: Shimmer.fromColors(
        baseColor: utils.baseShimmerColor,
        highlightColor: utils.highlightShimmerColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 40,
                        color: utils.widgetShimmerColor,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 30,
                        width: 60,
                        color: utils.widgetShimmerColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    color: utils.widgetShimmerColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    color: utils.widgetShimmerColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
