import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/app_colors.dart';

class AppsFunction {

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
      bool? barrierDismissible}) {
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
