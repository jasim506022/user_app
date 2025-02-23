import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';

import '../../res/app_string.dart';
import '../../res/valudation.dart';
import 'widget/custom_auth_button_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_form_field_widget.dart';
import 'widget/auth_page_intro.dart';

/// This Page allows users to reset their password by entering their email.
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  /// Controller for handling authentication-related logic
  late final AuthController authController;
  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    /// Get the `AuthController` instance for managing authentication.
    authController = Get.find<AuthController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // Prevents Back when Loadng True
      onPopInvoked: (didPop) => authController.resetFormIfNotLoading(), //
      child: GestureDetector(
        onTap: () => FocusScope.of(context)
            .unfocus(), // Dismiss keyboard when tapping outside.
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Displays an introduction (title & description).
                  AuthIntroWidget(
                    title: AppString.forgetPasswordTitle,
                    description: AppString.forgetPasswordDescription,
                  ),

                  /// Displays the form.
                  _buildForm(),
                  AppsFunction.verticalSpacing(10),

                  /// Reset Password Button.
                  AuthButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      await authController.resetPassword();
                    },
                    label: AppString.resetPasswordTitle,
                  ),
                  AppsFunction.verticalSpacing(20),
                  RichTextWidget(
                    highlightedText: AppString.signInTitle,
                    onTap: () async {
                      if (!authController.loadingController.loading.value) {
                        Get.back();
                        authController.resetFields();
                      }
                    },
                    normalText: AppString.youdontWantToReset,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Builds the password reset form**
  Form _buildForm() {
    return Form(
      key: formKey,
      child: CustomTextFormField(
        label: AppString.emailLabel,
        hintText: AppString.emailHint,
        controller: authController.emailController,
        validator: Validators.validateEmail,
        textInputType: TextInputType.emailAddress,
      ),
    );
  }
}

/*
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
                const AppSignInPageIntroWidget(
                  title: "Forget Your Password?",
                  description:
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
*/

/*
class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!authController.loadingController.loading.value) {
          authController.clearInputFields();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthPageIntro(
                  title: AppString.forgetPassword,
                  description: AppString.entreEmailAddressForResetPassword,
                ),
                _buildForgetPasswordForm(),
                AppsFunction.verticalSpacing(10),
                CustomAuthButtonWidget(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    await NetworkUtili.executeWithInternetCheck(
                        function: () async =>
                            await authController.resetPassword());
                  },
                  title: AppString.resetPassword,
                ),
                AppsFunction.verticalSpacing(20),
                RichTextWidget(
                  colorText: AppString.signIn,
                  function: () async {
                    if (!authController.loadingController.loading.value) {
                      Get.back();
                      authController.clearInputFields();
                    }
                  },
                  simpleText: AppString.youdontWantToReset,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form _buildForgetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            label: AppString.forgetPassword,
            hintText: AppString.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}

*/