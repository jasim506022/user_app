import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/app_function.dart';
import '../res/utils.dart';

/// A loading placeholder widget for the user profile header,
/// using shimmer effects to indicate loading state.
class LoadingUserProfileHeader extends StatelessWidget {
  const LoadingUserProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 1.sw,
      child: Shimmer.fromColors(
        baseColor: Utils.baseShimmerColor, // Base shimmer color.
        highlightColor: Utils.highlightShimmerColor, // Highlight shimmer color.
        child: Row(
          children: [
            // Circular shimmer placeholder for the profile picture.
            AppsFunction.buildShimmerEffect(height: 50, isCircle: true),
            AppsFunction.horizontalSpacing(13),

            // Column with two shimmer placeholders for text lines.
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppsFunction.buildShimmerEffect(
                    height: 10, width: 250), // First shimmer line.
                AppsFunction.buildShimmerEffect(
                    height: 10, width: 250), // Second shimmer line.
              ],
            ),

            const Spacer(),

            // Circular shimmer placeholder for a trailing icon.
            AppsFunction.buildShimmerEffect(height: 35, isCircle: true),
            AppsFunction.horizontalSpacing(10),
          ],
        ),
      ),
    );
  }
}
