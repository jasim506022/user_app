import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../res/app_function.dart';
import '../widget/default_shimmer_widget.dart';

class LoadingSingleProductWidget extends StatelessWidget {
  const LoadingSingleProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultShimmerWidget(
      padding: 15,
      height: 120,
      widget: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppsFunction.horizontalSpacing(5),
          AppsFunction.buildShimmerEffect(height: 100, width: 130),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    3,
                    (index) => AppsFunction.buildShimmerEffect(height: 15),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
