import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../data/response/app_data_exception.dart';
import 'app_colors.dart';
import 'apps_text_style.dart';
import 'utils.dart';

class AppsFunction {
  // ======================
  // UI Helpers
  // ======================

  static SizedBox verticalSpacing(double height) => SizedBox(height: height.h);
  static SizedBox horizontalSpacing(double width) => SizedBox(width: width.w);

  static Container buildShimmerEffect(
      {required double height, double? width, bool isCircle = false}) {
    return Container(
      height: height.h,
      width: isCircle ? height.h : (width?.w ?? 1.sw),
      decoration: BoxDecoration(
        color: Utils.widgetShimmerColor,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(15.r),
      ),
    );
  }

  // ======================
  // Validation Functions
  // ======================

  // Email Validation
  static bool isValidEmail(String email) {
    String emailRegex = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)*[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  // ======================
  // Utility Functions
  // ======================

  static void flutterToast({required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.sp);
  }

// ======================
  // Price Calculation
  // ======================

  /// Calculates the discounted price for a product.

  static double calculateDiscountedPrice(double productprice, double discount) {
    return productprice - (productprice * discount / 100);
  }

  /// Calculates the total price for a product with a given quantity.
  static double calculateTotalPrice(
      double productprice, double discount, int quantity) {
    return calculateDiscountedPrice(productprice, discount) * quantity;
  }

  /// Converts an amount in dollars to taka using a given conversion rate.
  static String convertDollarToTaka(String amount) {
    final int parsedAmount = int.parse(amount) * 100;
    return parsedAmount.toString();
  }

  // ======================
  // Input Decorations
  // ======================
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

  /// Builds input decoration for text fields.
  static InputDecoration textFormFielddecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      bool isEnable = true,
      required Function function}) {
    return InputDecoration(
        fillColor: isEnable ? AppColors.searchColorLight : Utils.textFeildColor,
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
                  color: obscureText ? AppColors.hintTextlight : AppColors.red,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: AppsTextStyle.hintTextStyle);
  }

  // ======================
  // Exception Handling
  // ======================
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

  // ======================
  // Delivery Date Estimation
  // ======================

  static String formatDeliveryDate({required String datetime}) {
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(datetime));
    return DateFormat("yyyy-MM-dd").format(date);
  }

  static String estimateDeliveryDate = DateTime.now()
      .add(const Duration(days: 15))
      .millisecondsSinceEpoch
      .toString();

  /// This function provides a pre-defined text field decoration with options for:
  static InputDecoration textFieldInputDecoration(
      {bool isShowPassword = false,
      required String hintText,
      bool obscureText = false,
      bool isEnable = true,
      VoidCallback? onPasswordToggle}) {
    // ✅ More specific type}
    return InputDecoration(
        // Background color changes based on enabled state

        fillColor: isEnable ? AppColors.searchColorLight : Utils.textFeildColor,
        filled: true,
        hintText: hintText,
        // Border styling: No border, rounded corners
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(15.r)),
        // Adds password visibility toggle if needed
        suffixIcon: isShowPassword
            ? IconButton(
                onPressed: onPasswordToggle ?? () {}, // ✅ Safe null handling,
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: obscureText ? AppColors.hintTextlight : AppColors.red,
                ))
            : null,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        hintStyle: AppsTextStyle.hintTextStyle);
  }
}
