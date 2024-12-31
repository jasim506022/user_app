import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  String? productId;
  String? productcategory;
  String? productdescription;
  List<dynamic>? productimage;
  String? productname;
  double? productprice;
  double? productrating;
  num? discount;
  String? sellerId;
  String? productunit;
  Timestamp? publishDate;

  ProductModel(
      {this.productId,
      this.productcategory,
      this.productdescription,
      this.productimage,
      this.productname,
      this.productprice,
      this.productrating,
      this.productunit,
      this.sellerId,
      this.publishDate,
      this.discount});

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'],
      productcategory: map['productcategory'],
      productdescription: map['productdescription'],
      productimage: map['productimage'],
      productname: map['productname'],
      productprice: map['productprice'],
      productrating: map['productrating'],
      productunit: map['productunit'],
      publishDate: map['publishDate'],
      discount: map['discount'],
      sellerId: map['sellerId'],
    );
  }
}
