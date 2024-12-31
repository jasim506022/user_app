import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_string.dart';

class NetworkUtili {
  static Future<bool> verifyInternetStatus() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    bool checkInternet = connectivityResult.contains(ConnectivityResult.none);
    if (checkInternet) {
      showNoInternetSnackbar();
    }
    return checkInternet;
  }

  static SnackbarController showNoInternetSnackbar() {
    return Get.snackbar(AppString.noInternet, AppString.noInternetMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.black.withOpacity(.7),
        colorText: AppColors.white,
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.zero,
        borderRadius: 0);
  }

  /// A utility function to verify internet status before executing an action
  static Future<void> verifyInternetAndExecute(
      Future<void> Function() action) async {
    if (!await verifyInternetStatus()) {
      await action();
    }
  }
}
