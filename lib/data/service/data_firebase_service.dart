import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_app/data/service/base_firebase_service.dart';
import 'package:user_app/model/productsmodel.dart';

import '../../model/profilemodel.dart';

class DataFirebaseService implements BaseFirebaseService {
  @override
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @override
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @override
  FirebaseStorage get firebaseStorage => FirebaseStorage.instance;

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
    Reference storageRef =
        firebaseStorage.ref().child("UserImage").child(fileName);
    UploadTask uploadTask = storageRef.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    return taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future<UserCredential> createUserWithEmilandPasword(
          {required String email, required String password}) async =>
      await firebaseAuth.createUserWithEmailAndPassword(
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
  Stream<QuerySnapshot<Map<String, dynamic>>> popularProductSnapshot(
          {required String category}) =>
      category == "All"
          ? firebaseFirestore
              .collection("products")
              .where("productrating", isGreaterThan: 3.5)
              .snapshots()
          : firebaseFirestore
              .collection("products")
              .where("productcategory", isEqualTo: category)
              .where("productrating", isGreaterThan: 3.5)
              .snapshots();

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> productSnapshots(
          {required String category}) =>
      category == "All"
          ? firebaseFirestore
              .collection("products")
              .orderBy("publishDate", descending: true)
              .snapshots()
          : firebaseFirestore
              .collection("products")
              .where("productcategory", isEqualTo: category)
              .orderBy("publishDate", descending: true)
              .snapshots();

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> similarProductSnapshot(
      {required ProductModel productModel}) {
    return firebaseFirestore
        .collection("products")
        .where("productId", isNotEqualTo: productModel.productId)
        .where("productcategory", isEqualTo: productModel.productcategory)
        .snapshots();

    //
  }

  @override
  Future<void> forgetPasswordSnapshot({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
