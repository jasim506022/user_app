import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/products_model.dart';

abstract class ProductServiceBase {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPopularProducts(
      {required String category});

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryProducts(
      {required String category});

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel});
}
