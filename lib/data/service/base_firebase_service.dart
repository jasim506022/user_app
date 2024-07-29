import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../model/productsmodel.dart';
import '../../model/profilemodel.dart';

abstract class BaseFirebaseService {
  FirebaseAuth get firebaseAuth;
  FirebaseFirestore get firebaseFirestore;
  FirebaseStorage get firebaseStorage;

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
