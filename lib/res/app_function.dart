import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/app_colors.dart';

import '../data/response/app_data_exception.dart';
import '../widget/custom_text_button_widget.dart';

class AppsFunction {
  static Future<bool?> showBackDialog() {
    return Get.dialog<bool>(AlertDialog(
      backgroundColor: AppColors.white,
      title: Row(
        children: [
          Text("Exit",
              style: GoogleFonts.poppins(
                  letterSpacing: 1.8,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black)),
          const SizedBox(
            width: 5,
          ),
          Container(
              padding: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
              child: Icon(
                Icons.question_mark_rounded,
                color: AppColors.white,
              )),
        ],
      ),
      content: Text('Are you sure you want to Exit this Apps?',
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black)),
      actions: [
        CustomTextButtonWidget(
          textColor: AppColors.red,
          colorBorder: AppColors.red,
          title: "Yes",
          onPressed: () {
            Get.back(result: true);
          },
        ),
        CustomTextButtonWidget(
          colorBorder: AppColors.greenColor,
          title: "No",
          onPressed: () {
            Get.back(result: false);
          },
        ),
      ],
    ));
  }

  static saveDialog() {
    return Get.dialog<bool>(AlertDialog(
      backgroundColor: AppColors.white,
      title: Row(
        children: [
          Text("Save Changed?",
              style: GoogleFonts.poppins(
                  letterSpacing: 1.8,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black)),
          const SizedBox(
            width: 5,
          ),
          Container(
              padding: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
              child: Icon(
                Icons.question_mark_rounded,
                color: AppColors.white,
              )),
        ],
      ),
      content: Text('do you want to save change?',
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black)),
      actions: [
        CustomTextButtonWidget(
          textColor: AppColors.red,
          colorBorder: AppColors.red,
          title: "Yes",
          onPressed: () {
            Get.back();
          },
        ),
        CustomTextButtonWidget(
          colorBorder: AppColors.greenColor,
          title: "No",
          onPressed: () {
            Get.back();
            Get.back();
          },
        ),
      ],
    ));
  }

  static deleteDialog({required VoidCallback function}) {
    return Get.dialog(AlertDialog(
      backgroundColor: AppColors.white,
      title: Row(
        children: [
          Text("Confirm Deletion?",
              style: GoogleFonts.poppins(
                  letterSpacing: 1.8,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black)),
          const SizedBox(
            width: 5,
          ),
          Container(
              padding: const EdgeInsets.all(5),
              decoration:
                  BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
              child: Icon(
                Icons.delete,
                color: AppColors.white,
              )),
        ],
      ),
      content: Text(
          'Are you sure you want to delete this item? This action cannot be undone.',
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.black)),
      actions: [
        CustomTextButtonWidget(
            textColor: AppColors.red,
            colorBorder: AppColors.red,
            title: "Yes",
            onPressed: function),
        CustomTextButtonWidget(
          colorBorder: AppColors.greenColor,
          title: "No",
          onPressed: () {
            Get.back();
          },
        ),
      ],
    ));
  }

  static bool isValidEmail(String email) {
    // understand Easly RegExp with Example
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  static void handleException(Object e) {
    if (e is FirebaseAuthException) {
      throw FirebaseAuthExceptions(e);
    } else if (e is FirebaseException) {
      throw FirebaseExceptions(e);
    } else if (e is SocketException) {
      throw InternetException(e.toString());
    } else if (e is PlatformException) {
      throw PlatformExceptions(e);
    } else if (e is FileSystemException) {
      throw FileSystemExceptions(e.toString());
    } else if (e is OutOfMemoryError) {
      throw OutOfMemoryErrors(e.toString());
    } else if (e is TimeoutException) {
      throw TimeOutExceptions(e.message.toString());
    } else {
      throw OthersException(e.toString());
    }
  }

  // Rich Text
  static RichText buldRichText(
      {required BuildContext context,
      required String simpleText,
      required String colorText,
      required Function function}) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: simpleText,
        style: GoogleFonts.poppins(
            color: AppColors.cardDarkColor, fontWeight: FontWeight.w500),
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
              color: AppColors.greenColor,
              fontWeight: FontWeight.w800))
    ]));
  }

  static Future<bool> internetChecking() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.none);
  }

  static flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  static void errorDialog(
      {required String icon,
      required String title,
      String? content,
      String? buttonText,
      bool? barrierDismissible,
      bool? checkInternet}) {
    Get.defaultDialog(
        barrierDismissible: barrierDismissible ?? true,
        contentPadding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        title: "",
        content: Column(
          children: [
            Image.asset(
              icon,
              height: 100,
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                  color: AppColors.deepGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 15,
            ),
            if (content != null)
              Text(
                content,
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSerif4(fontSize: 16),
              ),
            const SizedBox(
              height: 20,
            ),
            if (buttonText != null)
              CustomRoundButtonWidget(
                buttonColors: AppColors.red,
                width: Get.width,
                title: buttonText,
                onPress: () {
                  Get.back();
                },
              )
          ],
        ));
  }

//Product Price
  static double productPrice(double productprice, double discount) {
    return productprice - (productprice * discount / 100);
  }

  //Product Price
  static double productPriceWithQuantity(
      double productprice, double discount, int quantity) {
    return (productprice - (productprice * discount / 100)) * quantity;
  }
}

class CustomRoundButtonWidget extends StatelessWidget {
  const CustomRoundButtonWidget({
    super.key,
    required this.title,
    required this.onPress,
    this.buttonColors,
    this.width = 60,
    this.height = 50,
  });

  final String title;
  final double height, width;
  final VoidCallback onPress;
  final Color? buttonColors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
          height: height,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: Get.width * .2),
          decoration: BoxDecoration(
              color: buttonColors ?? AppColors.greenColor,
              borderRadius: BorderRadius.circular(50)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}

/*

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({super.key, required this.onPressed, required this.buttonText});

  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    // final loadingController = Get.put(LoadingController());
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(10),
          )),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        ),
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
        label: Obx(() {
          return loadingController.isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.white,
                  ),
                )
              : Text(buttonText,
                  style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14));
        }));
  }
}

*/

class SimpleButtonWidget extends StatelessWidget {
  const SimpleButtonWidget(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.color});

  final VoidCallback onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        ),
        onPressed: onPressed,
        child: Text(title,
            style: GoogleFonts.poppins(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)));
  }
}
