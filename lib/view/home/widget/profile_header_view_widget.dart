import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/app_string.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/cart_badge.dart';

class ProfileHeaderViewWidget extends StatelessWidget {
  const ProfileHeaderViewWidget({
    super.key,
    required this.image,
    required this.name,
  });
  final String image;
  final String name;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 1.sw,
      child: Row(
        children: [
          // Profile Image with circular border.

          Container(
            height: 50.h,
            width: 50.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.red, width: 2.w)),
            child: ClipOval(
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          AppsFunction.horizontalSpace(13),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppString.hi,
                  style: AppsTextStyle.titleTextStyle
                      .copyWith(color: AppColors.deepGreenAccent)),
              Text(
                name,
                style: AppsTextStyle.boldBodyTextStyle,
              )
            ],
          ),
          const Spacer(),

          // Cart badge with item count and navigation functionality.
          InkWell(onTap: () async {
            if (!(await AppsFunction.verifyInternetStatus())) {
              Get.toNamed(RoutesName.cartPage);
            }
          }, child: Obx(() {
            return CartBadge(
                color: AppColors.accentGreen,
                itemCount: Get.find<CartController>().itemCount,
                icon: Icons.shopping_bag);
          })),
          AppsFunction.horizontalSpace(12)
        ],
      ),
    );
  }
}
