import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/data/service/cart_service_base.dart';
import 'package:user_app/res/app_string.dart';

import '../../res/cart_funtion.dart';

class CartServiceData extends CartServiceBase {
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSellersForCart() {
    return firebaseFirestore
        .collection(AppString.firebaseSellerCollection)
        .where(AppString.firebaseuid,
            whereIn: CartFunctions.separteSellerListUserList())
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchProductsInCartBySeller(
      {required String sellerId}) {
    return firebaseFirestore
        .collection(AppString.productCollection)
        .where("sellerId", isEqualTo: sellerId)
        .where("productId", whereIn: CartFunctions.separateProductID())
        .orderBy(AppString.publishDate, descending: true)
        .snapshots();

    //
  }
}
