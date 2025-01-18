import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../model/products_model.dart';
import '../../res/app_constant.dart';
import '../../res/app_string.dart';
import 'product_service_base.dart';

class ProductServiceData extends ProductServiceBase {
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchPopularProducts(
      {required String category}) {
    var collectionRef =
        firebaseFirestore.collection(AppString.productCollection);

    var query =
        collectionRef.where(AppString.productRating, isGreaterThan: 3.5);

    if (category != AppConstant.cateogryTypes[0]) {
      query = query.where(AppString.productCategory, isEqualTo: category);
    }

    return query.snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchCategoryProducts(
      {required String category}) {
    var collectionRef =
        firebaseFirestore.collection(AppString.productCollection);
    var query = collectionRef.orderBy(AppString.publishDate, descending: true);

    if (category != AppConstant.cateogryTypes[0]) {
      query = query.where(AppString.productCategory, isEqualTo: category);
    }

    return query.snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchSimilarProducts(
      {required ProductModel productModel}) {
    return firebaseFirestore
        .collection(AppString.productCollection)
        .where(AppString.productId, isNotEqualTo: productModel.productId)
        .where(AppString.productCategory,
            isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }
}
