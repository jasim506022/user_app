import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/constants.dart';
import 'package:user_app/model/profilemodel.dart';


import '../service/database/firebasedatabase.dart';

import 'app_colors.dart';

class GlobalMethod {
  final ImagePicker picker = ImagePicker();

// IsValidEmail

// Elevate Button Style
  ButtonStyle elevateButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: AppColors.greenColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.022, vertical: Get.height * 0.018),
      );

  // Firebase Auth Error Handlig
 /*
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
*/
// Text Form Field Decoration
  

  // flutterToast({required String msg}) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.BOTTOM,
  //       backgroundColor:AppColors. red,
  //       textColor: AppColors.white,
  //       fontSize: 16.0);
  // }

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
            AppsFunction.flutterToast(msg: "User Doesn't Exist");
          }
        }
      });
    } catch (error) {
      AppsFunction.flutterToast(msg: "Error:  $error");
    }
  }

  // getImageFromDevice(BuildContext context, ImageSource imageSource) async {
  //   ImageUploadProvider imageUploadProvider =
  //       Provider.of<ImageUploadProvider>(context, listen: false);
  //   XFile? imageXFiles = await picker.pickImage(source: imageSource);

  //   imageUploadProvider.setImage(imageXFiles!);
  // }

// //Product Price
//   double productPrice(double productprice, double discount) {
//     return productprice - (productprice * discount / 100);
//   }

  String getFormateDate(
      {required BuildContext context, required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
