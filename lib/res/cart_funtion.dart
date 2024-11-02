import 'package:get/get.dart';

import 'package:user_app/res/constants.dart';

import '../controller/cart_controller.dart';
import '../controller/profile_controller.dart';
import 'app_function.dart';
import 'constant/string_constant.dart';

class CartFunctions {


  static void addItemToCart({
    required String productId,
    required int quantity,
    required String sellerId,
  }) {
    List<String> cartItems = sharedPreference!
            .getStringList(StringConstant.cartListSharedPreference) ??
        [];
    String itemEntry = "$productId:$sellerId:$quantity";

    cartItems.add(itemEntry);

    Get.find<ProfileController>()
        .updateUserCartData(map: {"cartlist": cartItems});
    AppsFunction.flutterToast(msg: "Item Add Successfully");

    sharedPreference!
        .setStringList(StringConstant.cartListSharedPreference, cartItems);

    Get.find<CartController>().incrementCartItem();
  }



  static void clearCart() {
    sharedPreference!.setStringList("cartlist", ["initial"]);
    List<String> emptyCart = sharedPreference!.getStringList("cartlist")!;

    /*
    FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
*/
    var profileController = Get.find<ProfileController>();
    profileController.updateUserCartData(map: {"cartlist": emptyCart});
    AppsFunction.flutterToast(msg: "Remove All Cart Successfully");
    // FirebaseDatabase.currentUserSnaphots()
    //     .update({"cartlist": emptyCart}).then((value) {
    //   AppsFunction.flutterToast(msg: "Remove All Cart Successfully");
    // });
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

  //[2,3,4]
  // Separet Product Quantity List From CartList
  static int productQuantiyList(String prodductId) {
    List<String> list =
        sharedPreference!.getStringList("cartlist")!.skip(1).toList();

    String? matchingItem = list.firstWhere(
      (element) => element.contains(prodductId),
    );

    return int.parse(matchingItem.split(":")[2]);
  }

// Separete Seller List From CartList
  static List<String> separteSellerListUserList() {
    return [
      for (var item in sharedPreference!.getStringList("cartlist")!.skip(1))
        (item.toString().split(":")[1])
    ];
  }

/*
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
*/

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

  static List<String> separateOrderSellerCartList(productIds) {
    List<String> listProductIds = List<String>.from(productIds);
    return [
      for (var item in listProductIds.skip(1)) item.toString().split(":")[1]
    ];
  }

  static List<String> separteOrderProductIdList(productIds) {
    List<dynamic> listProductIds = List<dynamic>.from(productIds);

    return [
      for (var item in listProductIds.skip(1)) (item.toString().split(":")[0])
    ];
  }

  static List<int> separateOrderItemQuantities(productIds) {
    List<String> listProductIds = List<String>.from(productIds);
    return [
      for (var item in listProductIds.skip(1))
        int.parse(item.toString().split(":")[2])
    ];
  }
}
