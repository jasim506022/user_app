import 'package:get/get.dart';

import '../controller/cart_controller.dart';
import '../controller/profile_controller.dart';
import 'app_constant.dart';
import 'app_function.dart';
import 'app_string.dart';

// Final and Const
class CartManager {
  /// Adds a product to the cart with its quantity and seller ID.
  static void addProductToCart({
    required String productId,
    required int quantity,
    required String sellerId,
  }) {
    final sharedPref = AppConstant.sharedPreference!;
    const cartKey = AppString.cartListSharedPreference;

// Retrieve existing cart items or initialize an empty list
    List<String> cartItems = sharedPref.getStringList(cartKey) ?? [];
    // Create a new item entry
    String itemEntry = "$productId:$sellerId:$quantity";

    cartItems.add(itemEntry);

    Get.find<ProfileController>().updateUserCartData(map: {cartKey: cartItems});

    AppsFunction.flutterToast(msg: AppString.itemAddSuccessfully);
    // Save updated cart in shared preferences
    sharedPref.setStringList(cartKey, cartItems);
    // Update cart count
    Get.find<CartController>().incrementCartItem();
  }

  // Clear the entire cart
  static void clearCart() {
    final sharedPref = AppConstant.sharedPreference!;
    const cartKey = AppString.cartListSharedPreference;
    // Reset cart data
    sharedPref.setStringList(cartKey, ["initial"]);
    List<String> emptyCart = sharedPref.getStringList(cartKey)!;

    Get.find<ProfileController>().updateUserCartData(map: {cartKey: emptyCart});
    AppsFunction.flutterToast(msg: AppString.removieAllCartSuccessfully);
  }

// Retrieve a specific field (helper function)
  static List<T> _extractField<T>({
    required int index,
    required T Function(String) transform,
  }) {
    return [
      for (var item in AppConstant.sharedPreference!
          .getStringList(AppString.cartListSharedPreference)!
          .skip(1))
        transform(item.split(":")[index])
    ];
  }

  static List<String> getProductIds() {
    return _extractField(index: 0, transform: (value) => value);
  }

  // Separate product quantities from the cart
  static List<int> getProductQuantities() {
    return _extractField(index: 2, transform: (value) => int.parse(value));
  }

// Separate seller IDs from the cart
  static List<String> getSellerIds() {
    return _extractField(
      index: 1,
      transform: (value) => value,
    );
  }

  // Separet Product Quantity List From CartList
  // Get the quantity of a specific product
  static int getProductQuantity(String productId) {
    final sharedPref = AppConstant.sharedPreference!;
    final cartItems =
        sharedPref.getStringList(AppString.cartListSharedPreference)!;

    // Find matching product entry
    String? matchingItem = cartItems.skip(1).firstWhere(
          (item) => item.contains(productId),
        );

    if (matchingItem.isNotEmpty) {
      return int.parse(matchingItem.split(":")[2]);
    }

    return 0;
  }

  static Set<String> getSelletSet() {
    return AppConstant.sharedPreference!
        .getStringList(AppString.cartListSharedPreference)!
        .skip(1)
        .map((seller) => "${seller.split(":")[1]}:false")
        .toSet();
  }

  static List<String> getOrderSellerIDs(List<dynamic> productIds) {
    List<String> listProductIds = List<String>.from(productIds);
    return listProductIds.skip(1).map((item) => item.split(":")[1]).toList();
  }

  static List<String> getOrderProductsIds(List<dynamic> productIds) {
    List<String> listProductIds = List<String>.from(productIds);
    return listProductIds.skip(1).map((item) => item.split(":")[0]).toList();
  }

/*
  static List<int> getOrderProductQuantities(productIds) {
    // List<String> listProductIds = List<String>.from(productIds);
    return productIds
        .skip(1)
        .map((item) => int.parse((item as String).split(":")[2]))
        .toList();
  }
  */

  static List<int> getOrderProductQuantities(List<dynamic> productIds) {
    return productIds
        .skip(1)
        .map((item) =>
            int.parse((item as String).split(":")[2])) // Cast to String
        .toList();
  }
}








/*
 Separete Seller List From CartList
  static List<String> getSellerIds() {
    return [
      for (var item in AppConstant.sharedPreference!
          .getStringList(AppString.cartListSharedPreference)!
          .skip(1))
        (item.toString().split(":")[1])
    ];
  }

*/

/*
  static List<String> getOrderSellerIDs(productIds) {
    List<String> listProductIds = List<String>.from(productIds);
    return [
      for (var item in listProductIds.skip(1)) item.toString().split(":")[1]
    ];
  }

*/













    

 // FirebaseDatabase.currentUserSnaphots()
    //     .update({"cartlist": emptyCart}).then((value) {
    //   AppsFunction.flutterToast(msg: "Remove All Cart Successfully");
    // });


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

/*
  static int productQuantiyList(String prodductId) {
    List<String> list = AppConstant.sharedPreference!
        .getStringList("cartlist")!
        .skip(1)
        .toList();

    String? matchingItem = list.firstWhere(
      (element) => element.contains(prodductId),
    );

    return int.parse(matchingItem.split(":")[2]);
  }

*/
/*
  static int productQuantiyList(String prodductId) {
    List<String>? cartList = sharedPreference!.getStringList("cartlist");

    if (cartList == null || cartList.isEmpty) {
      return 0; // Default quantity if cart list is empty or null
    }

    List<String> list = cartList.skip(1).toList();

    String? matchingItem = list.firstWhere(
      (element) => element.contains(prodductId),
      orElse: () => "",
    );

    if (matchingItem.isEmpty) {
      return 0; // Default quantity if no match is found
    }

    return int.parse(matchingItem.split(":")[2]);
  }
*/