import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_function.dart';

import '../res/app_asset/app_icons.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    _connectivity.onConnectivityChanged.listen(updateConnectionState);
    super.onInit();
  }

  void showInternetMessage() {
    _connectivity.onConnectivityChanged.listen(updateConnectionState);
  }

  void updateConnectionState(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      AppsFunction.errorDialog(
          icon: AppIcons.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    }
  }
}

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
