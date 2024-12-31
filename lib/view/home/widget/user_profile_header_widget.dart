import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../controller/profile_controller.dart';
import '../../../model/profile_model.dart';

import '../../../res/app_constant.dart';
import '../../../res/app_string.dart';

import '../../../loading_widget/loading_header_user_profile.dart';
import 'profile_header_view_widget.dart';

class UserProfileHeaderWidget extends StatelessWidget {
  const UserProfileHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Retrieve controllers using GetX dependency injection.
    final profileController = Get.find<ProfileController>();
    final cartController = Get.find<CartController>();

    // Retrieve cached data from SharedPreferences.
    String? imageUrl = AppConstant.sharedPreference
        ?.getString(AppString.imageSharedPreference);
    String? name =
        AppConstant.sharedPreference?.getString(AppString.nameSharedPreference);

    List<String>? cartList = AppConstant.sharedPreference
        ?.getStringList(AppString.cartListSharedPreference);

    // Check if cached data is unavailable or empty.
    final isDataEmpty = (imageUrl?.isEmpty ?? true) &&
        (name?.isEmpty ?? true) &&
        (cartList?.isEmpty ?? true);

    if (isDataEmpty) {
      return FutureBuilder(
        future: profileController.getUserInformation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingUserProfileHeader();
          } else if (snapshot.hasData) {
            var data = snapshot.data!.data();
            if (data != null) {
              var profileModel = ProfileModel.fromMap(data);
              cartController.initializeCartItemCount();
              return ProfileHeaderViewWidget(
                  image: profileModel.imageurl!, name: profileModel.name!);
            }
          }
          return const LoadingUserProfileHeader();
        },
      );
    } else {
      return ProfileHeaderViewWidget(
        image: imageUrl!,
        name: name!,
      );
    }
  }
}
