import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_string.dart';

import '../model/app_exception.dart';
import '../repository/order_repository.dart';
import '../res/app_asset/app_icons.dart';
import '../widget/error_dialog_widget.dart';

class OrderController extends GetxController {
  OrderRepository orderRepository;

  OrderController(this.orderRepository);

  /// Okay
  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    try {
      return orderRepository.orderSnapshots(orderStatus: orderStatus);
    } catch (e) {
      if (e is AppException) {
        _handleError(e);
      }

      rethrow;
    }
  }

  /// Okay
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> listProductID}) async {
    try {
      return await orderRepository.orderProductSnapshots(
          listProductID: listProductID);
    } catch (e) {
      if (e is AppException) {
        _handleError(e);
      }
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId}) async {
    try {
      return await orderRepository.sellerProductSnapshot(
          productList: productList, sellerId: sellerId);
    } catch (e) {
      if (e is AppException) {
        _handleError(e);
      }
      rethrow;
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId}) {
    try {
      return orderRepository.orderAddressSnapsot(addressId: addressId);
    } catch (e) {
      if (e is AppException) {
        _handleError(e);
      }
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> sellerOrderSnapshot(
      {required List<String> sellerList}) {
    try {
      return orderRepository.sellerOrderSnapshot(sellerList: sellerList);
    } catch (e) {
      if (e is AppException) {
        _handleError(e);
      }

      rethrow;
    }
  }

  void _handleError(AppException e) {
    Get.dialog(
      ErrorDialogWidget(
        icon: AppIcons.warningIcon,
        title: e.title!,
        content: e.message,
        buttonText: AppString.okay,
      ),
    );
  }
}
