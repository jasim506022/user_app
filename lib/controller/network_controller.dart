import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../res/app_asset/app_icons.dart';
import '../res/app_string.dart';
import '../widget/error_dialog_widget.dart';

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
      Get.dialog(
        const ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: "e.title!",
          content: "e.message",
          buttonText: AppString.okay,
        ),
      );
      //   AppsFunction.errorDialog(
      //       icon: AppIcons.warningIcon,
      //       title: "No Internet Connection",
      //       content: "Please check your internet settings and try again.",
      //       buttonText: "Okay");
    }
  }
}

class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
