import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/data/service/cart_service_data.dart';

import '../res/app_function.dart';

class CartRepository {
  final _artServiceData = CartServiceData();

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSellersForCart() {
    try {
      return _artServiceData.fetchSellersForCart();
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductsInCartBySeller(
      {required String sellerId}) {
    try {
      return _artServiceData.fetchProductsInCartBySeller(sellerId: sellerId);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
