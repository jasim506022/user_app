import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/repository/order_repository.dart';

import '../model/app_exception.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';

class OrderController extends GetxController {
  OrderRepository orderRepository = OrderRepository();

  Stream<QuerySnapshot<Map<String, dynamic>>> allOrderSnapshots() {
    try {
      return orderRepository.allOrderSnapshots();
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<dynamic> itemIDDetails}) async {
    try {
      return await orderRepository.orderProductSnapshots(
          itemIDDetails: itemIDDetails);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }
}
