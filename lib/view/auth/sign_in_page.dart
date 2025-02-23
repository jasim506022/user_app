import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_asset/app_icons.dart';
import '../../res/app_function.dart';

import '../../res/app_colors.dart';
import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../res/routes/routes_name.dart';
import '../../res/valudation.dart';
import 'widget/custom_auth_button_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/custom_text_form_field.dart';
import '../../res/network_utili.dart';
import 'widget/auth_page_intro.dart';
import 'widget/icon_with_button_widget.dart';

/// A sign-in page where users can log in with email/password or social accounts.
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  /// Controller for handling authentication-related logic
  late final AuthController authController;
  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    /// Get the `AuthController` instance for managing authentication.
    authController = Get.find<AuthController>();
    _configureStatusBar();
    super.initState();
  }

  /// Configures the system UI to set the status bar color and icon brightness.
  void _configureStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.backgroundLight,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked:
          (didPop) async => // Prevents accidental app exit without confirmation.
              await authController.confirmExitApp(didPop),
      child: GestureDetector(
        // Dismiss keyboard when tapping outside.
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Displays an introduction (title & description).
                  const AuthIntroWidget(
                    title: AppString.userLoginTitle,
                    description: AppString.authPageDescription,
                  ),

                  /// Displays the form.
                  _buildForm(),
                  AppsFunction.verticalSpacing(5),

                  /// "Forgot Password" button.
                  _buildForgetPasswordButton(),
                  AppsFunction.verticalSpacing(15),

                  /// Login Button  Button.
                  AuthButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await authController.signIn();
                    },
                    label: AppString.signInTitle,
                  ),
                  AppsFunction.verticalSpacing(25),

                  /// OR divider section.
                  _buildOrDivider(),
                  AppsFunction.verticalSpacing(20),

                  /// Social login buttons (Google & Facebook)
                  _buildSocialLoginOptions(),
                  AppsFunction.verticalSpacing(25),

                  /// Sign-up link with navigation to the registration page.
                  RichTextWidget(
                    highlightedText: AppString.createAccount,
                    onTap: () => Get.toNamed(AppRoutesName.signUpPage),
                    normalText: AppString.dontHaveAccount,
                  ),
                  AppsFunction.verticalSpacing(100)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the login form containing email and password input fields
  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// Email input field.
          CustomTextFormField(
            label: AppString.emailLabel,
            hintText: AppString.emailHint,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          /// Password input field
          CustomTextFormField(
            label: AppString.passwordLabel,
            hasPasswordToggle: true,
            obscureText: true,
            validator: Validators.validatePassword,
            hintText: AppString.passwordHint,
            controller: authController.passwordController,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }

  /// Builds the "Forgot Password" button.
  Widget _buildForgetPasswordButton() {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () async {
          await NetworkUtils.executeWithInternetCheck(
              action: () => Get.toNamed(AppRoutesName.forgetPasswordPage));
        },
        child: Text(
          AppString.forgetPasswordTitle,
          style: AppsTextStyle.mediumBoldText.copyWith(
            color: AppColors.hintTextlight,
          ),
        ),
      ),
    );
  }

  /// Builds a divider with "OR" text in the center.
  Row _buildOrDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLine(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            AppString.withOr,
            style:
                AppsTextStyle.mediumNormalText.copyWith(color: AppColors.grey),
          ),
        ),
        _buildLine(),
      ],
    );
  }

  /// Builds the social login options row (e.g., Facebook and Gmail).
  Row _buildSocialLoginOptions() {
    return Row(
      children: [
        Expanded(
          /// Facebook login button.
          child: SocialButton(
            onTap: () {},
            color: AppColors.facebookBlue,
            iconPath: AppIcons.facebookIcon,
            label: AppString.btnFacebook,
          ),
        ),
        AppsFunction.horizontalSpacing(10),
        Expanded(
          /// Facebook login button.
          child: SocialButton(
            onTap: () async {
              await authController.signInWithGoogle();
            },
            color: AppColors.red,
            iconPath: AppIcons.gmailIcon,
            label: AppString.btnGmail,
          ),
        ),
      ],
    );
  }

  /// Builds a horizontal line for the divider.
  Container _buildLine() {
    return Container(
      height: 2.5.h,
      width: 70.w,
      color: AppColors.grey,
    );
  }
}





/*
//formKey.currentState?.validate() and resetting with formKey.currentState?.reset()
#: SignInPage	SignInScreen	"Screen" is more descriptive than "Page"
#: Which is best way to declare variable name   
final AuthController authController = Get.find<AuthController>(); 
or final AuthController authController = Get.find<AuthController>() 
#: final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
#: Why use dispose

*/