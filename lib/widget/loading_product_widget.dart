import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../res/utils.dart';

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .78,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          color: Theme.of(context).cardColor,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          child: Container(
            color: Theme.of(context).cardColor,
            height: 1.sh,
            width: 1.sw,
            child: Shimmer.fromColors(
              baseColor: utils.baseShimmerColor,
              highlightColor: utils.highlightShimmerColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 100.h,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(5.r),
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                              color: utils.widgetShimmerColor,
                              borderRadius: BorderRadius.circular(5.r)),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 15.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: utils.widgetShimmerColor,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 15.h,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.r),
                              color: utils.widgetShimmerColor,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 15,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: utils.widgetShimmerColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
