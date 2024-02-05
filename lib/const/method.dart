import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_app/const/const.dart';
import 'package:user_app/model/profilemodel.dart';
import 'package:user_app/service/provider/image_upload_provider.dart';

import '../service/database/firebasedatabase.dart';
import '../service/provider/loading_provider.dart';
import '../widget/show_error_dialog_widget.dart';
import 'gobalcolor.dart';

class GlobalMethod {
  final ImagePicker picker = ImagePicker();

// IsValidEmail
  bool isValidEmail(String email) {
    // understand Easly RegExp with Example
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

// Elevate Button Style
  ButtonStyle elevateButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * 0.022, vertical: mq.height * 0.018),
      );

  // Firebase Auth Error Handlig
  void handleError(
    BuildContext context,
    dynamic e,
    LoadingProvider loadingProvider,
  ) {
    Navigator.pop(context);

    String title;
    String message;

    switch (e.code) {
      case 'email-already-in-use':
        title = 'Email Already in Use';
        message = 'Email Already In User. Please Use Another Email';
        break;
      case 'invalid-email':
        title = 'Invalid Email Address';
        message = 'Invalid Email address. Please put Valid Email Address';
        break;
      case 'weak-password':
        title = 'Invalid Password';
        message = 'Invalid Password. Please Put Valid Password';
        break;
      case 'too-many-requests':
        title = 'Too Many Requests';
        message = 'Too many requests';
        break;
      case 'operation-not-allowed':
        title = 'Operation Not Allowed';
        message = 'Operation Not Allowed';
        break;
      case 'user-disabled':
        title = 'User Disabled';
        message = 'User Disable';
        break;
      case 'user-not-found':
        title = 'User Not Found';
        message = 'User Not Found';
        break;
      case 'wrong-password':
        title = 'Incorrect password';
        message = 'Password Incorrect. Please Check your Password';
        break;
      default:
        title = 'Error Occurred';
        message = 'Please check your internet connection or other issues.';
        break;
    }

    showDialog(
      context: context,
      builder: (context) =>
          ShowErrorDialogWidget(title: title, message: message),
    );

    loadingProvider.setLoading(loading: false);
  }

// Text Form Field Decoration
  InputDecoration textFormFielddecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      required Function function}) {
    return InputDecoration(
      labelStyle:
          GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      fillColor: searchLightColor,
      filled: true,
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(15)),
      suffixIcon: isShowPassword
          ? IconButton(
              onPressed: () {
                function();
              },
              icon: Icon(
                Icons.password,
                color: obscureText ? hintLightColor : red,
              ))
          : null,
      contentPadding: EdgeInsets.symmetric(
          horizontal: mq.width * .033, vertical: mq.height * .025),
      hintStyle: const TextStyle(
        color: Color(0xffc8c8d5),
      ),
    );
  }

  flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

// Rich Text
  RichText buldRichText(
      {required BuildContext context,
      required String simpleText,
      required String colorText,
      required Function function}) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: simpleText,
        style: GoogleFonts.poppins(
            color: cardDarkColor, fontWeight: FontWeight.w500),
      ),
      TextSpan(

          // Differece reognizer.Why use this
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              function();
            },
          text: colorText,
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                decoration: TextDecoration.underline,
              ),
              color: greenColor,
              fontWeight: FontWeight.w800))
    ]));
  }

// Get User All Information on Share
  getUserInformation() async {
    try {
      await FirebaseDatabase.currentUserDataSnapshot().then((snapshot) async {
        if (snapshot.exists) {
          ProfileModel profileModel = ProfileModel.fromMap(snapshot.data()!);
          if (profileModel.status == "approved") {
            await sharedPreference!.setString("uid", profileModel.uid!);
            await sharedPreference!.setString("email", profileModel.email!);
            await sharedPreference!.setString("name", profileModel.name!);
            await sharedPreference!
                .setString("imageurl", profileModel.imageurl!);
            if (kDebugMode) {
              print(sharedPreference!.getString("imageurl"));
            }
            await sharedPreference!.setString("phone", profileModel.phone!);
            List<String> list =
                profileModel.cartlist!.map((e) => e.toString()).toList();
            await sharedPreference!.setStringList("cartlist", list);
          } else {
            flutterToast(msg: "User Doesn't Exist");
          }
        }
      });
    } catch (error) {
      flutterToast(msg: "Error:  $error");
    }
  }

  getImageFromDevice(BuildContext context, ImageSource imageSource) async {
    ImageUploadProvider imageUploadProvider =
        Provider.of<ImageUploadProvider>(context, listen: false);
    XFile? imageXFiles = await picker.pickImage(source: imageSource);

    imageUploadProvider.setImage(imageXFiles!);
  }

//Product Price
  double productPrice(double productprice, double discount) {
    return productprice - (productprice * discount / 100);
  }

  String getFormateDate(
      {required BuildContext context, required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
