import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../res/app_function.dart';
import '../../res/cart_funtion.dart';
import '../../res/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../model/profilemodel.dart';
import '../../widget/show_error_dialog_widget.dart';

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
  static Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // Sign In With Gmail
  static Future<UserCredential?> signWithGoogle(
      {required BuildContext context}) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        return await auth.signInWithCredential(credential);
      } else {
        AppsFunction.flutterToast(msg: "No Internet Connection");
      }
    } catch (e) {
      // I don't use Mounted . What is problem to show error
      // ignore: use_build_context_synchronously
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) {
          return ShowErrorDialogWidget(
              message: "Error Ocured: $e", title: 'Error Occured');
        },
      );
      return null;
    }
    return null;
  }

// user is Exist on Database
  static Future<bool> userExists() async =>
      (await firestore.collection("users").doc(auth.currentUser!.uid).get())
          .exists;

  // Create User and Post Data Firebase
  static Future<void> createUserGmail() async {
    ProfileModel profileModel = ProfileModel(
        name: user.displayName,
        cartlist: ["initial"],
        status: "approved",
        email: user.email,
        phone: user.phoneNumber,
        uid: user.uid,
        address: "",
        imageurl: user.photoURL);

    firestore.collection("users").doc(user.uid).set(profileModel.toMap());
  }

// create User With Email and Password Snapshot
  static Future<UserCredential> createUserWithEmilandPaswordSnaphsot(
      {required String email, required String password}) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  // Create User and Post Data Firebase
  static Future<void> createUserByEmailPassword(
      {required UserCredential userCredential,
      required String phone,
      required String name,
      required String image}) async {
    ProfileModel profileModel = ProfileModel(
        name: name,
        status: "approved",
        email: userCredential.user!.email,
        phone: "0$phone",
        uid: userCredential.user!.uid,
        address: "",
        cartlist: ["initial"],
        imageurl: image);
    firestore
        .collection("users")
        .doc(userCredential.user!.uid)
        .set(profileModel.toMap());
  }

  // forget Password Snapshort
  // static Future<void> forgetPasswordSnapshot({required String email}) async {
  //   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  // }

// Current User All Firestore Data Data
  static Future<DocumentSnapshot<Map<String, dynamic>>>
      currentUserDataSnapshot() async {
    return firestore.collection("users").doc(auth.currentUser!.uid).get();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
      .instance
      .collection("products")
      .orderBy("publishDate", descending: true)
      .snapshots();

  static Future<UserCredential> createUserWithEmailPassword(
      String email, String password) {
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> createUserSetSnapshot(
      String collection, String id, Map<String, dynamic> map) async {
    await firestore.collection(collection).doc(id).set(map);
  }

// Product Firebase
  /*
  static Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
          {required String category}) =>
      category == "All"
          ? firestore
              .collection("products")
              .orderBy("publishDate", descending: true)
              .snapshots()
          : firestore
              .collection("products")
              .where("productcategory", isEqualTo: category)
              .orderBy("publishDate", descending: true)
              .snapshots();
*/
/*
// Popular Product Firebase
  static Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
          {required String category}) =>
      category == "All"
          ? firestore
              .collection("products")
              .where("productrating", isGreaterThan: 3.5)
              .snapshots()
          : firestore
              .collection("products")
              .where("productcategory", isEqualTo: category)
              .where("productrating", isGreaterThan: 3.5)
              .snapshots();
              */

// Similar  Product Firebase

/*
  static Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return FirebaseFirestore.instance
        .collection("products")
        .where("productId", isNotEqualTo: productModel.productId)
        .where("productcategory", isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }
  */

// Cart Seller
  // static Stream<QuerySnapshot<Map<String, dynamic>>> cartSellerSnapshot() {
  //   return FirebaseFirestore.instance
  //       .collection("seller")
  //       .where("uid", whereIn: CartMethods.separteSellerListUserList())
  //       .snapshots();

  //   //
  // }

// Cart Product
  // static Stream<QuerySnapshot<Map<String, dynamic>>> cartProductSnapshot(
  //     {required String sellerId}) {
  //   return FirebaseFirestore.instance
  //       .collection("products")
  //       .where("sellerId", isEqualTo: sellerId)
  //       .where("productId",
  //           whereIn: CartMethods.separeteProductIdUserCartList())
  //       .orderBy("publishDate", descending: true)
  //       .snapshots();

  //   //
  // }

// All Address Firebase
/*
  static DocumentReference<Map<String, dynamic>> allorUpdateAddressSnapshot(
      {required String id}) {
    var address = FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
        .collection("useraddress")
        .doc(id);
    return address;
    //
  }
  */
/*

// All User Address
  static Stream<QuerySnapshot<Map<String, dynamic>>> alluserAddressSnapshot() {
    var address = FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!)
        .collection("useraddress")
        .snapshots();
    return address;
    //
  }

*/
// Save Order Details For user
  static saveOrderDetailsForUser(
      {required Map<String, dynamic> orderDetailsMap,
      required String orderId}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

// Save Order Details For Seller
  static saveOrderDetailsForSeller(
      {required Map<String, dynamic> orderDetailsMap,
      required String orderId}) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  Future<void> saveOrderDetails(
      {required Map<String, dynamic> orderMetailsMap,
      required String orderId}) async {
    String userId = sharedPreference!.getString("uid")!;
    final userPath = "users/$userId/orders";
    const sellerPth = "orders"; // What is different between final and const;
    final firestore = FirebaseFirestore.instance;
    final userUpload =
        firestore.collection(userPath).doc(orderId).set(orderMetailsMap);
    final sellerUpload =
        firestore.collection(sellerPth).doc(orderId).set(orderMetailsMap);

    await Future.wait([userUpload, sellerUpload]);
  }

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
  static Stream<QuerySnapshot<Map<String, dynamic>>> allCompleteSnapshots() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .collection("orders")
        .where("status", isEqualTo: "complete")
        .snapshots();

    //
  }

// All Order Seller Snpashot
  static Stream<QuerySnapshot<Map<String, dynamic>>> orderSelerSnapshots(
      {required List<String> list}) {
    return FirebaseFirestore.instance
        .collection("seller")
        .where("uid", whereIn: list)
        .snapshots();

    //
  }

//  Order Snpashot
  static Stream<DocumentSnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderId}) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .snapshots();

    //
  }

// Order Product Snpashot
  static Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required Map<String, dynamic> snpshot}) {
    // var name = (snpshot)["uid"];
    // var imags = CartMethods.separteOrderProductIdList((snpshot)["productIds"]);

    return FirebaseFirestore.instance
        .collection("products")
        .where("productId",
            whereIn: CartFunctions.separteOrderProductIdList(
                (snpshot)["productIds"]))
        // .where("orderBy", whereIn: (snpshot)["uid"])
        .orderBy("publishDate", descending: true)
        .get();

    //
  }

// Order Product Snpashot
  static Future<QuerySnapshot<Map<String, dynamic>>>
      deliveryOrderProductSnapshots({required List<dynamic> list}) {
    return FirebaseFirestore.instance
        .collection("products")
        .where("productId",
            whereIn: CartFunctions.separteOrderProductIdList(list))
        .orderBy("publishDate", descending: true)
        .get();

    //
  }

// User Details
  static Stream<DocumentSnapshot<Map<String, dynamic>>> userDetails() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .snapshots();

    //
  }

// Address
  static Stream<DocumentSnapshot<Map<String, dynamic>>> addressSnapsot() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .snapshots();

    //
  }

// Address
  static Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId}) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid"))
        .collection("useraddress")
        .doc(addressId)
        .snapshots();
  }

// Current User
  static DocumentReference<Map<String, dynamic>> currentUserSnaphots() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreference!.getString("uid")!);
  }
}
