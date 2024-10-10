import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../res/cart_funtion.dart';
import '../../res/constants.dart';

class FirebaseDatabase {
  // instance of FirebaseFirestore
  static final firestore = FirebaseFirestore.instance;
  //Instance of FirebaseAuth
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Firebse Storeage Reference
  static Reference storageRef = FirebaseStorage.instance.ref();
  // Current User Instance
  static User get user => auth.currentUser!;

// Can i use Stream in here . if is not possible then why is not possible
// Sign in out Email and Password

  // Create User and Post Data Firebase

  // forget Password Snapshort
  // static Future<void> forgetPasswordSnapshot({required String email}) async {
  //   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  // }

// Current User All Firestore Data Data

// Save Order Details For user

// Save Order Details For Seller

/*
// All Order Snpashot
  static Stream<QuerySnapshot<Map<String, dynamic>>> allOrderSnapshots() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .collection("orders")
        .where("status", isEqualTo: "normal")
        .snapshots();

    //
  }
  
  */

// All Order Snpashot

// // All Order Seller Snpashot
//   static Stream<QuerySnapshot<Map<String, dynamic>>> orderSelerSnapshots(
//       {required List<String> list}) {
//     return FirebaseFirestore.instance
//         .collection("seller")
//         .where("uid", whereIn: list)
//         .snapshots();

//     //
//   }

//  Order Snpashot

// // Order Product Snpashot
//   static Future<QuerySnapshot<Map<String, dynamic>>>
//       productListBySellerSnapshot(
//           {required List<dynamic> list, required String sellerId}) {
//     return FirebaseFirestore.instance
//         .collection("products")
//         .where("sellerId", isEqualTo: sellerId)
//         .where("productId",
//             whereIn: CartFunctions.separteOrderProductIdList(list))
//         .orderBy("publishDate", descending: true)
//         .get();

//     //
//   }

// Address
  // static Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
  //     {required String addressId}) {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(sharedPreference!.getString("uid"))
  //       .collection("useraddress")
  //       .doc(addressId)
  //       .snapshots();
  // }

// Current User
  static DocumentReference<Map<String, dynamic>> currentUserSnaphots() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!);
  }
}
