import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CartServiceBase {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSellersForCart();

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductsInCartBySeller(
      {required String sellerId});
}
