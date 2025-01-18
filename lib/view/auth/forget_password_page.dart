import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/forget_password_controller.dart';
import '../../res/app_function.dart';

import '../../../res/app_colors.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_form_field_widget.dart';
import '../../res/network_utili.dart';
import 'widget/app_sign_page_intro.dart';
import 'widget/custom_button_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var forgetPasswordController = Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        NetworkUtili.verifyInternetStatus();
      },
      child: Material(
        color: AppColors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppSignInPageIntro(
                  title: "Forget Your Password?",
                  subTitle:
                      "Please Enter your mail address to reset you password",
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: formKey,
                  child: TextFormFieldWidget(
                    hintText: 'Email Address',
                    controller: forgetPasswordController.emailET,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your Email';
                      } else if (!AppsFunction.isValidEmail(value)) {
                        return 'Please Enter a Valid Email Address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomButtonWidget(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    forgetPasswordController.forgetPasswordButton();
                  },
                  title: 'Reset Password',
                ),
                SizedBox(
                  height: 15.h,
                ),
                RichTextWidget(
                    colorText: "Sign In",
                    function: () async {
                      if (!(await NetworkUtili.verifyInternetStatus())) {
                        Get.back();
                      }
                    },
                    simpleText: "If you don't want to reset Password? "),
                SizedBox(
                  height: .2.sh,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
