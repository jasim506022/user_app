import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/profile_controller.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/controller/cart_product_counter_controller.dart';
import 'package:user_app/res/constants.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

class CartFunctions {
  static void addItemToCartWithSeller({
    required String productId,
    required int productCounter,
    required String seller,
  }) {
    List<String> tempList = sharedPreference!.getStringList("cartlist")!;
    tempList.add("$productId:$seller:$productCounter");

    var controller = Get.find<CartProductCountController>();
    var profileController = Get.find<ProfileController>();
    profileController.updateUserData(map: {"cartlist": tempList});
    AppsFunction.flutterToast(msg: "Item Add Successfully");
    sharedPreference!.setStringList("cartlist", tempList);
    controller.addCartItem();

    // separateProductID();
    // separteProductQuantityUserCartList();
  }

  static void clearCart() {
    sharedPreference!.setStringList("cartlist", ["initial"]);
    List<String> emptyCart = sharedPreference!.getStringList("cartlist")!;

    /*
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
*/
    FirebaseDatabase.currentUserSnaphots()
        .update({"cartlist": emptyCart}).then((value) {
      AppsFunction.flutterToast(msg: "Remove All Cart Successfully");
    });
  }

// Separet Product Id From CartList
  static List<String> separateProductID() {
    return [
      for (var item in sharedPreference!.getStringList("cartlist")!.skip(1))
        item.toString().split(":")[0]
    ];
  }

// Separet Product Quantity List From CartList
  static List<int> seperateProductQuantiyList() {
    return [
      for (var item in sharedPreference!.getStringList("cartlist")!.skip(1))
        int.parse(item.toString().split(":")[2])
    ];
  }

// Separete Seller List From CartList
  static List<String> separteSellerListUserList() {
    List<String> userCartList = sharedPreference!.getStringList("cartlist")!;
    List<String> sellerList = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      int lastChaterPositionOfItembeforeColon = item.lastIndexOf(":");
      String productandSeller =
          item.substring(0, lastChaterPositionOfItembeforeColon);
      List<String> splistProductAndSelelr =
          productandSeller.split(":").toList();
      String sellerId = splistProductAndSelelr[1].toString();
      sellerList.add(sellerId);
    }
    if (kDebugMode) {
      print(sellerList);
    }
    return sellerList;
  }
/*
  // Separete Seller List From CartList
  static Set<String> seperateSellerSet() {
    List<String> userCartList = sharedPreference!.getStringList("cartlist")!;
    Set<String> sellerList = {};
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      int lastChaterPositionOfItembeforeColon = item.lastIndexOf(":");
      String productandSeller =
          item.substring(0, lastChaterPositionOfItembeforeColon);
      List<String> splistProductAndSelelr =
          productandSeller.split(":").toList();
      String sellerId = splistProductAndSelelr[1].toString();
      sellerList.add("$sellerId:false");
    }
    if (kDebugMode) {
      print(sellerList);
    }
    return sellerList;
  }

*/



  static Set<String> seperateSellerSet() {
    return sharedPreference!
        .getStringList("cartlist")!
        .skip(1)
        .map((seller) => "${seller.split(":")[1]}:false")
        .toSet();
  }

  static List<int> seperfateProductQuantiyList() {
    return [
      for (var item in sharedPreference!.getStringList("cartlist")!.skip(1))
        int.parse(item.toString().split(":")[2])
    ];
  }

  static separateOrderSellerCartList(productIds) {
    List<String> userCartList = List<String>.from(productIds);
    List<String> itemSellerDetails = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var lastChaterPositionOfItembeforeColon = item.lastIndexOf(":");
      String getItemId = item.substring(0, lastChaterPositionOfItembeforeColon);
      var colonAndAfterCharaList = getItemId.split(":").toList();
      String sellerItemId = colonAndAfterCharaList[1].toString();
      // var getStringSeller = getItemId.lastIndexOf(":");
      // String sellerItemId = item.substring(0, getStringSeller);
      itemSellerDetails.add(sellerItemId);
    }
    if (kDebugMode) {
      print(itemSellerDetails);
    }
    return itemSellerDetails;
  }

  static separteOrderProductIdList(productIds) {
    List<dynamic> userCartList = List<dynamic>.from(productIds);

    List<String> itemIDDetails = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();

      var lastChaterPositionOfItembeforeColon = item.indexOf(":");
      String getItemId = item.substring(0, lastChaterPositionOfItembeforeColon);

      itemIDDetails.add(getItemId);
    }

    return itemIDDetails;
  }

  static separateOrderItemQuantities(productIds) {
    List<String> userCartList = List<String>.from(productIds);
    List<int> itemQuantity = [];

    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var colonAndafterCharaListh = item.split(":").toList();

      int qunatityNumber = int.parse(colonAndafterCharaListh[2].toString());
      itemQuantity.add(qunatityNumber);
    }
    if (kDebugMode) {
      print("Item Qunaity List");
    }

    return itemQuantity;
  }
}

/*
 // List<int> productQuanityList = [];
    // for (int i = 1; i < userCartList.length; i++) {
    //   String item = userCartList[i].toString();
    //   List<String> splitCartList = item.split(":").toList();
    //   int quatityProduct = int.parse(splitCartList[2].toString());
    //   productQuanityList.add(quatityProduct);
    // }
    // return productQuanityList;
    */