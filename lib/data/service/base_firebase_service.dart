import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_app/model/address_model.dart';

import '../../model/productsmodel.dart';
import '../../model/profilemodel.dart';

abstract class BaseFirebaseService {
  FirebaseAuth get firebaseAuth;
  FirebaseFirestore get firebaseFirestore;
  FirebaseStorage get firebaseStorage;

  Future<User?> getCurrentUser();

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password});
  Future<UserCredential?> signWithGoogle();
  Future<bool> userExists();
  Future<void> createUserGmail({required User user});

  Future<String> uploadUserImgeUrl({required File file});

  Future<UserCredential> createUserWithEmilandPasword(
      {required String email, required String password});

  Future<void> uploadNewUserCreatingDocument(
      {required ProfileModel profileModel, required String firebaseDocument});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInformationSnapshot();

  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
      {required String category});

  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
      {required String category});

  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel});

  Future<void> forgetPasswordSnapshot({required String email});

  Stream<QuerySnapshot<Map<String, dynamic>>> cartSellerSnapshot();

  Stream<QuerySnapshot<Map<String, dynamic>>> cartProductSnapshot(
      {required String sellerId});

  Future<void> uploadOrUpdateAddress(
      {required AddressModel addressModel, required bool isUpdate});

  Stream<QuerySnapshot<Map<String, dynamic>>> addressSnapshot();
  Future<void> deleteAddress({required String addressId});

  Future<void> saveOrderDetails(
      {required Map<String, dynamic> orderMetailsMap, required String orderId});

  Future<Map<String, dynamic>> postRequest(
      {required String endpoint,
      required Map<String, String> body,
      required String baseUrl,
      required Map<String, String> headers});

  Stream<QuerySnapshot<Map<String, dynamic>>> allOrderSnapshots();

  // Order Product Snpashot
  Future<QuerySnapshot<Map<String, dynamic>>> orderProductSnapshots(
      {required List<dynamic> itemIDDetails});

  Future<void> updateUserData({required Map<String, dynamic> map});

  Future<void> signOutApp();

  /*
   // static Future<void> forgetPasswordSnapshot({required String email}) async {
  //   await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  // }
  */

  /*
Future<void> createUserByEmailPassword(
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
  */
}
