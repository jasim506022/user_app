import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/data/service/product_service_data.dart';

import '../model/products_model.dart';
import '../res/app_function.dart';

class ProductReposity {
  final productServiceBase = ProductServiceData();

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPopularProducts(
      {required String category}) {
    try {
      return productServiceBase.fetchPopularProducts(category: category);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryProducts(
      {required String category}) {
    try {
      return productServiceBase.fetchCategoryProducts(category: category);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel}) {
    try {
      return productServiceBase.fetchSimilarProducts(
          productModel: productModel);
    } catch (e) {
      AppsFunction.handleException(e);
      rethrow;
    }
  }
}
