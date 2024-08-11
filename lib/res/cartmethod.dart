import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/routes/routesname.dart';
import 'package:user_app/service/provider/cart_product_counter_provider.dart';
import 'package:user_app/res/constants.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

class CartMethods {
  // Add Item to CartWithSeller
  // Okay Done
  static void addItemToCartWithSeller(
      {required String productId,
      required int productCounter,
      required String seller,
      required BuildContext context}) {
    List<String> tempList = sharedPreference!.getStringList("cartlist")!;
    tempList.add("$productId:$seller:$productCounter");

    var controller = Get.put(CartProductCountController());

    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
        .update({"cartlist": tempList}).then((value) {
      AppsFunction.flutterToast(msg: "Item Add Successfully");
      sharedPreference!.setStringList("cartlist", tempList);
      controller.addCartItem();
      separeteProductIdUserCartList();
      separteProductQuantityUserCartList();
    });
  }

  static void addItemToCart(
      {required String productId,
      required int productCounter,
      required BuildContext context}) {
    List<String> tempList = sharedPreference!.getStringList("cartlist")!;

    tempList.add("$productId:$productCounter");

    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
        .update({"cartlist": tempList}).then((value) {
      AppsFunction.flutterToast(msg: "Item Add Successfully");

      sharedPreference!.setStringList("cartlist", tempList);
      // try to add
      // Provider.of<CartProductCountProvider>(context, listen: false)
      //     .addCartItem();
      separeteProductIdUserCartList();
      separteProductQuantityUserCartList();
    });
  }

//Remove Product from Cart
  static void removeProdctFromCart(
      {required int index, required BuildContext context}) async {
    List<String> cartList = sharedPreference!.getStringList("cartlist")!;
    if (kDebugMode) {
      print(cartList[index]);
    }
    cartList.remove(cartList[index]);

    await FirebaseDatabase.currentUserSnaphots()
        .update({"cartlist": cartList}).then((value) {
      AppsFunction.flutterToast(msg: "Item remove Successfully");

      sharedPreference!.setStringList("cartlist", cartList);

      CartMethods.separeteProductIdUserCartList();
      CartMethods.separteProductQuantityUserCartList();

      // Provider.of<CartProductCountProvider>(context, listen: false)
      //     .removeCartItem();
      var controller = Get.put(CartProductCountController());
      controller.removeCartItem();

      // print(cartList.length);

      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const CartPage(),
      //     ));
      Get.toNamed(RoutesName.mainPage);
    });
  }

// Clear All Cart
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
  static List<String> separeteProductIdUserCartList() {
    // List<String> userCartList = sharedPreference!.getStringList("cartlist")!;
    return [
      for (var item in sharedPreference!.getStringList("cartlist")!.skip(1))
        item.toString().split(":")[0]
    ];
    // List<String> productIdList = [];
    // for (int i = 1; i < userCartList.length; i++) {
    //   String item = userCartList[i].toString();
    //   int indexChatePositionProductColon = item.indexOf(":");
    //   String productId = item.substring(0, indexChatePositionProductColon);
    //   productIdList.add(productId);
    // }
    // return productIdList;
  }

// Separet Product Quantity List From CartList
  static List<int> separteProductQuantityUserCartList() {
    // List<String> userCartList = sharedPreference!.getStringList("cartlist")!;
    return [
      for (var item in sharedPreference!.getStringList("cartlist")!.skip(1))
        int.parse(item.toString().split(":")[2])
    ];
    // List<int> productQuanityList = [];
    // for (int i = 1; i < userCartList.length; i++) {
    //   String item = userCartList[i].toString();
    //   List<String> splitCartList = item.split(":").toList();
    //   int quatityProduct = int.parse(splitCartList[2].toString());
    //   productQuanityList.add(quatityProduct);
    // }
    // return productQuanityList;
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

  // Separete Seller List From CartList
  static Set<String> seperateSEllerSet() {
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
