import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/product_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../model/profilemodel.dart';
import '../../../res/app_colors.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/constant/string_constant.dart';
import '../../../res/constants.dart';
import '../../../res/routes/routes_name.dart';
import '../../../widget/cart_badge.dart';
import '../../../widget/header_loading.dart';

class UserProfileHeaderWidget extends StatelessWidget {
  const UserProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    String? imageUrl =
        sharedPreference?.getString(StringConstant.imageSharedPreference);
    String? name =
        sharedPreference?.getString(StringConstant.nameSharedPreference);
List<String>? cartList =
        sharedPreference?.getStringList(StringConstant.cartListSharedPreference);

    if ((imageUrl?.isEmpty ?? true) && (name?.isEmpty ?? true) && (cartList==null)) {
      return FutureBuilder(
        future: profileController.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LodingHeader();
          } else if (snapshot.hasData) {
            var data = snapshot.data!.data();
            if (data != null) {
              var profileModel = ProfileModel.fromMap(data);
              return _buildUserProfileHeader(
                  image: profileModel.imageurl!, name: profileModel.name!);
            }
          }
          return const LodingHeader();
        },
      );
    } else {
      return _buildUserProfileHeader(image: imageUrl!, name: name!);
    }
  }

  SizedBox _buildUserProfileHeader(
      {required String image, required String name}) {
    return SizedBox(
      height: 36.h,
      width: 1.sw,
      child: Row(
        children: [
          Container(
            height: 36.h,
            width: 36.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.red, width: 3.w)),
            child: ClipOval(
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(
                  backgroundColor: AppColors.white,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 13.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi!",
                  style: AppsTextStyle.largestText
                      .copyWith(color: AppColors.greenColor)),
              Text(
                name,
                style: AppsTextStyle.largeText,
              )
            ],
          ),
          const Spacer(),
          InkWell(onTap: () {
            Get.toNamed(RoutesName.cartPage);
          }, child: Obx(() {
            var productController = Get.find<ProductController>();
            return CartBadge(
                color: AppColors.greenColor,
                itemCount:
                    productController.cartProductCountController.getCounts,
                icon: Icons.shopping_bag);
          })),
          SizedBox(
            width: 10.w,
          ),
        ],
      ),
    );
  }
}
