import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:user_app/res/app_colors.dart';
import 'package:user_app/res/apps_text_style.dart';
import 'package:user_app/res/utils.dart';

import '../data/response/app_data_exception.dart';
import '../widget/round_button_widget.dart';
import '../widget/show_alert_dialog_widget.dart';

class AppsFunction {
  static Future<bool?> showBackDialog() {
    return Get.dialog<bool>(CustomAlertDialogWidget(
      icon: Icons.question_mark_rounded,
      title: "Exit",
      subTitle: 'Are you sure you want to Exit this Apps?',
      yesOnPress: () {
        Get.back(result: true);
      },
      noOnPress: () {
        Get.back(result: false);
      },
    ));
  }

  static Future<bool> verifyInternetStatus() async {
    bool checkInternet = await AppsFunction.internetChecking();
    if (checkInternet) {
      AppsFunction.showNoInternetSnackbar();
    }
    return checkInternet;
  }

  static Container lineShimmer(Utils utils, double height, [double? width]) {
    return Container(
      height: height,
      width: width ?? 1.sw,
      decoration: BoxDecoration(
          color: utils.widgetShimmerColor,
          borderRadius: BorderRadius.circular(15.r)),
    );
  }

  static Container circleShimmer(Utils utils, double height) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
          color: utils.widgetShimmerColor, shape: BoxShape.circle),
    );
  }

  // static confirmationDialog({
  //   required VoidCallback yesFunction,
  //   required String title,
  //   required String subTitle,
  //   VoidCallback? noFunction,
  // }) {
  //   return Get.dialog(CustomAlertDialogWidget(
  //       icon: Icons.question_mark_rounded,
  //       title: title,
  //       subTitle: subTitle,
  //       yesOnPress: yesFunction,
  //       noOnPress: noFunction!));
  // }

/*
  static confirmationDialog({
    required VoidCallback yesFunction,
    required String title,
    required String content,
    VoidCallback? noFunction,
  }) {
    return Get.dialog(AlertDialog(
      backgroundColor: AppColors.white,
      title: Row(
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  letterSpacing: 1.8,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black)),
          SizedBox(
            width: 5.w,
          ),
          Container(
              padding: EdgeInsets.all(5.r),
              decoration:
                  BoxDecoration(color: AppColors.red, shape: BoxShape.circle),
              child: Icon(
                Icons.delete,
                color: AppColors.white,
              )),
        ],
      ),
      content: Text(content,
          style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black)),
      actions: [
        DialogTextButtonWidget(
            textColor: AppColors.red,
            colorBorder: AppColors.red,
            title: "Yes",
            onPressed: yesFunction),
        DialogTextButtonWidget(
          colorBorder: AppColors.greenColor,
          title: "No",
          onPressed: noFunction ??
              () {
                Get.back();
              },
        ),
      ],
    ));
  }

  */

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

  static Future<bool> internetChecking() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    return connectivityResult.contains(ConnectivityResult.none);
  }

  static SnackbarController showNoInternetSnackbar() {
    return Get.snackbar(
        'No Internet', 'Please check your internet settings and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.black.withOpacity(.7),
        colorText: AppColors.white,
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.zero,
        borderRadius: 0);
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

  static void errorDialog({
    required String icon,
    required String title,
    String? content,
    String? buttonText,
    bool? barrierDismissible,
  }) {
    Get.defaultDialog(
        barrierDismissible: barrierDismissible ?? true,
        contentPadding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        title: "",
        content: Column(
          children: [
            Image.asset(
              icon,
              height: 100.h,
              width: 100.w,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              title,
              style: AppsTextStyle.titleTextStyle
                  .copyWith(color: AppColors.deepGreen),
            ),
            SizedBox(
              height: 15.h,
            ),
            if (content != null)
              Text(
                content,
                textAlign: TextAlign.center,
                style: AppsTextStyle.subTitleTextStyle,
              ),
            SizedBox(
              height: 20.h,
            ),
            if (buttonText != null)
              RoundButtonWidget(
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

  static String formatDeliveryDate({required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("yyyy-MM-dd").format(date);
  }

  static double calculateDiscountedPrice(double productprice, double discount) {
    return productprice - (productprice * discount / 100);
  }

//Product Price
  static double productPrice(double productprice, double discount) {
    return calculateDiscountedPrice(productprice, discount);
  }

  //Product Price
  static double productPriceWithQuantity(
      double productprice, double discount, int quantity) {
    return calculateDiscountedPrice(productprice, discount) * quantity;
  }

  static InputDecoration inputDecoration({
    required String hint,
  }) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff00B761), width: 1),
          borderRadius: BorderRadius.circular(15)),
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration textFormFielddecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      bool isEnable = true,
      required Function function}) {
    Utils utils = Utils();
    return InputDecoration(
        fillColor: isEnable ? AppColors.searchLightColor : utils.textFeildColor,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15)),
        suffixIcon: isShowPassword
            ? IconButton(
                onPressed: () {
                  function();
                },
                icon: Icon(
                  Icons.password,
                  color: obscureText ? AppColors.hintLightColor : AppColors.red,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: AppsTextStyle.hintTextStyle);
  }
}

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
