import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/controller/forget_password_controller.dart';

import '../../res/app_function.dart';
import '../../res/routes/routesname.dart';
import '../../../res/app_colors.dart';
import '../../widget/text_form_field_widget.dart';
import 'widget/app_sign_page_intro.dart';
import 'widget/custom_button_widget.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var forgetPasswordController = Get.put(ForgetPasswordController(
    Get.find(),
  ));
  Widget _buildForgetPassword() {
    return SizedBox(
      width: Get.width,
      child: CustomButtonWidget(
        onPressed: () async {
          if (!formKey.currentState!.validate()) return;
          forgetPasswordController.forgetPasswordButton();
        },
        title: 'Reset Password',
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
        color: AppColors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * .044, vertical: Get.width * .024),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppSignInPageIntro(
                  title: "Forget Your Password?",
                  subTitle:
                      "Please Enter your mail address to reset you password",
                ),
                SizedBox(
                  height: Get.height * 0.024,
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
                  height: Get.height * 0.024,
                ),
                _buildForgetPassword(),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                AppsFunction.buldRichText(
                    colorText: "Sign In",
                    context: context,
                    function: () {
                      Get.toNamed(RoutesName.signPage);
                    },
                    simpleText: "If you don't want to reset Password? "),
                SizedBox(
                  height: Get.height * 0.124,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
