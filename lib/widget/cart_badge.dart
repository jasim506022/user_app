import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';
import '../res/apps_text_style.dart';
import '../res/routes/routes_name.dart';
import '../res/network_utili.dart';

class CartBadge extends StatelessWidget {
  final int itemCount;
  final IconData icon;

  const CartBadge(
      {super.key,
      required this.itemCount,
      required this.icon,
      required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              icon,
              color: color,
            ),
            onPressed: () async {
              NetworkUtils.executeWithInternetCheck(action: () {
                Get.toNamed(AppRoutesName.cartPage);
              });
              // if (!(await NetworkUtili.verifyInternetStatus())) {
              //   Get.toNamed(AppRoutesName.cartPage);
              // }
            }),
        if (itemCount > 0)
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: AppColors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Text(
                itemCount.toString(),
                style: AppsTextStyle.buttonTextStyle.copyWith(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
