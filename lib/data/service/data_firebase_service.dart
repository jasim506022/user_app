import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_app/data/service/base_firebase_service.dart';
import 'package:user_app/model/address_model.dart';
import 'package:http/http.dart' as http;

import '../../model/order_model.dart';
import '../../model/profile_model.dart';
import '../../res/app_constant.dart';
import '../../res/app_string.dart';

class DataFirebaseService implements BaseFirebaseService {
  @override
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @override
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @override
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) {
    return firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<void> createUserGmail({required User user}) async {
    ProfileModel profileModel = ProfileModel(
        name: user.displayName,
        cartlist: ["initial"],
        status: "approved",
        email: user.email,
        phone: user.phoneNumber,
        uid: user.uid,
        address: "",
        imageurl: user.photoURL);

    firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(profileModel.toMap());
  }

  @override
  Future<UserCredential?> signWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<bool> userExists() async => (await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .get())
      .exists;

  @override
  Future<String> uploadUserImgeUrl({required File file}) async {
    String fileName = "ju_grocery_${DateTime.now().millisecondsSinceEpoch}";
    Reference storageRef = firebaseStorage
        .ref()
        .child("UserImage")
        .child(AppConstant.sharedPreference!
            .getString(AppString.nameSharedPreference)!)
        .child(firebaseAuth.currentUser!.uid)
        .child(fileName);
    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future<UserCredential> createUserWithEmilandPasword(
          {required String email, required String password}) async =>
      firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> uploadNewUserCreatingDocument(
      {required ProfileModel profileModel,
      required String firebaseDocument}) async {
    await firebaseFirestore
        .collection("users")
        .doc(firebaseDocument)
        .set(profileModel.toMap());
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformationSnapshot() {
    return firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
  }

  @override
  Future<void> forgetPasswordSnapshot({required String email}) async {
    firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> uploadOrUpdateAddress(
      {required AddressModel addressModel, required bool isUpdate}) async {
    if (isUpdate) {
      firebaseFirestore
          .collection("users")
          .doc(AppConstant.sharedPreference!.getString("uid")!)
          .collection("useraddress")
          .doc(addressModel.addressId)
          .update(addressModel.toMap());
    } else {
      firebaseFirestore
          .collection("users")
          .doc(AppConstant.sharedPreference!.getString("uid")!)
          .collection("useraddress")
          .doc(addressModel.addressId)
          .set(addressModel.toMap());
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> addressSnapshot() {
    return firebaseFirestore
        .collection("users")
        .doc(AppConstant.sharedPreference!.getString("uid")!)
        .collection("useraddress")
        .snapshots();
  }

  @override
  Future<void> deleteAddress({required String addressId}) async {
    await firebaseFirestore
        .collection("users")
        .doc(AppConstant.sharedPreference!.getString("uid")!)
        .collection("useraddress")
        .doc(addressId)
        .delete();
  }

/*
  @override
  Future<void> saveOrderDetails(
      {required Map<String, dynamic> orderMetailsMap,
      required String orderId}) async {
    String userId = AppConstant.sharedPreference!.getString("uid")!;
    final userPath = "users/$userId/orders";
    const sellerPth = "orders"; // What is different between final and const;
    final firestore = FirebaseFirestore.instance;
    final userUpload =
        firestore.collection(userPath).doc(orderId).set(orderMetailsMap);
    final sellerUpload =
        firestore.collection(sellerPth).doc(orderId).set(orderMetailsMap);

    await Future.wait([userUpload, sellerUpload]);
  }

*/

  @override
  Future<void> uploadOrderSnapshots({
    required OrderModel orderModel,
    // required String orderId
  }) async {
    String userId =
        AppConstant.sharedPreference!.getString(AppString.uidSharedPreference)!;
    final userPath =
        "${AppString.firebaseUserCollection}/$userId/${AppString.firebaseOrderCollection}";
    const sellerPth = AppString
        .firebaseOrderCollection; // What is different between final and const;
    final firestore = FirebaseFirestore.instance;
    final userUpload = firestore
        .collection(userPath)
        .doc(orderModel.orderId)
        .set(orderModel.toMap());
    final sellerUpload = firestore
        .collection(sellerPth)
        .doc(orderModel.orderId)
        .set(orderModel.toMap());

    await Future.wait([userUpload, sellerUpload]);
  }

  @override
  Future<Map<String, dynamic>> postRequest(
      {required String endpoint,
      required Map<String, String> body,
      required String baseUrl,
      required Map<String, String> headers}) async {
    final Uri url = Uri.parse(baseUrl);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> orderSnapshots(
      {required String orderStatus}) {
    return firebaseFirestore
        .collection("users")
        .doc(AppConstant.sharedPreference!.getString("uid"))
        .collection("orders")
        .where("status", isEqualTo: orderStatus)
        .snapshots();
  }

  // Order Product Snpashot
  @override
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<String> listProductID}) {
    return firebaseFirestore
        .collection("products")
        .where("productId", whereIn: listProductID)
        .orderBy("publishDate", descending: true)
        .get();
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> orderAddressSnapsot(
      {required String addressId}) {
    return firebaseFirestore
        .collection("users")
        .doc(AppConstant.sharedPreference!.getString("uid"))
        .collection("useraddress")
        .doc(addressId)
        .snapshots();
  }

  @override
  Future<void> updateUserData({required Map<String, dynamic> map}) async {
    firebaseFirestore
        .collection("users")
        .doc(AppConstant.sharedPreference!.getString("uid")!)
        .update(map);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> sellerOrderSnapshot(
      {required List<String> sellerList}) {
    return firebaseFirestore
        .collection("seller")
        .where("uid", whereIn: sellerList)
        .snapshots();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> sellerProductSnapshot(
      {required List<String> productList, required String sellerId}) async {
    return FirebaseFirestore.instance
        .collection("products")
        .where("sellerId", isEqualTo: sellerId)
        .where("productId", whereIn: productList)
        .orderBy("publishDate", descending: true)
        .get();
  }

  @override
  Future<void> signOutApp() async {
    firebaseAuth.signOut();
  }
}
