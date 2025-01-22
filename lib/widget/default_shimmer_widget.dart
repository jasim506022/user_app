import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/utils.dart';

class DefaultShimmerWidget extends StatelessWidget {
  const DefaultShimmerWidget(
      {super.key, this.padding, required this.height, required this.widget});

  final double? padding;
  final double height;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding?.w ?? 0,
      ),
      child: Card(
        child: SizedBox(
          height: height.h,
          child: Shimmer.fromColors(
              baseColor: Utils.baseShimmerColor,
              highlightColor: Utils.highlightShimmerColor,
              child: widget),
        ),
      ),
    );
  }
}
