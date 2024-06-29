import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/routes/routesname.dart';
import '../res/constants.dart';
import '../res/gobalcolor.dart';
import '../../service/database/firebasedatabase.dart';
import '../../widget/show_error_dialog_widget.dart';
import '../../widget/textfieldformwidget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailET = TextEditingController();

  @override
  void dispose() {
    _emailET.dispose();
    super.dispose();
  }

  Widget _buildForgetPassword() {
    return SizedBox(
      width: mq.width,
      child: ElevatedButton(
        style: globalMethod.elevateButtonStyle(),
        onPressed: () async {
          try {
            final result = await InternetAddress.lookup('google.com');
            if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
              await FirebaseDatabase.forgetPasswordSnapshot(
                      email: _emailET.text)
                  .then((value) {
                globalMethod.flutterToast(msg: "Please Check Your mail");
                Navigator.pushReplacementNamed(context, RoutesName.signPage);
              }).catchError((error) {
                globalMethod.flutterToast(msg: "Error Occured: $error");
              });
            } else {
              globalMethod.flutterToast(msg: "No Internet Connection");
            }
          } catch (e) {
            if (mounted) {
              showDialog(
                context: context,
                builder: (context) {
                  return ShowErrorDialogWidget(
                    message: e.toString(),
                    title: 'Error Occurred',
                  );
                },
              );
            }
          }
        },
        child: Text(
          "Reset Password",
          style: GoogleFonts.poppins(
              color: white, fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Material(
        color: white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * .044, vertical: mq.width * .024),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: mq.height * 0.071,
                ),
                Image.asset(
                  "asset/image/logo.png",
                  height: mq.height * 0.177,
                  width: mq.height * 0.177,
                ),
                SizedBox(
                  height: mq.height * 0.012,
                ),
                Text(
                  "Forget Your Password?",
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold, color: black),
                ),
                SizedBox(
                  height: mq.height * 0.03,
                ),
                Text(
                  "Please Enter your mail address to reset you password",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: hintLightColor),
                ),
                SizedBox(
                  height: mq.height * 0.024,
                ),
                TextFieldFormWidget(
                  hintText: 'Email Address',
                  controller: _emailET,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Email';
                    } else if (globalMethod.isValidEmail(value)) {
                      return 'Please Enter a Valid Email Address';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: mq.height * 0.024,
                ),
                _buildForgetPassword(),
                SizedBox(
                  height: mq.height * 0.03,
                ),
                globalMethod.buldRichText(
                    colorText: "Sign In",
                    context: context,
                    function: () {
                      Navigator.pushReplacementNamed(
                          context, RoutesName.signPage);
                    },
                    simpleText: "If you don't want to reset Password? "),
                SizedBox(
                  height: mq.height * 0.124,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
