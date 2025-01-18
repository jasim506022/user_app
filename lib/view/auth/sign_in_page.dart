import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:user_app/res/routes/routes_name.dart';

import '../../controller/network_controller.dart';
import '../../controller/sign_in_controller.dart';
import '../../res/app_asset/app_icons.dart';
import '../../res/app_function.dart';

import '../../res/app_colors.dart';
import '../../res/apps_text_style.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_form_field_widget.dart';
import '../../res/network_utili.dart';
import 'widget/app_sign_page_intro.dart';
import 'widget/custom_button_widget.dart';
import 'widget/icon_with_button_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInController signInController = Get.find();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  NetworkController networkController = Get.put(NetworkController());

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    DependencyInjection.init();
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        signInController.handleBackNavigaion(didPop);
        // if (didPop) {
        //   return;
        // }
        // final bool shouldPop = await AppsFunction.showBackDialog() ?? false;
        // if (shouldPop) {
        //   SystemNavigator.pop();
        // }
      },
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).unfocus();
          NetworkUtili.verifyInternetStatus();
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppSignInPageIntro(
                    title: "Welcome Back!",
                    subTitle: "Check our fresh viggies from Jasim Grocery",
                  ),
                  _buildLoginForm(),
                  SizedBox(
                    height: 5.h,
                  ),
                  _buildForgetPasswordButton(),
                  SizedBox(height: 15.h),
                  CustomButtonWidget(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      signInController.signInWithEmailAndPassword();
                    },
                    title: 'Sign In',
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  _buildOrDividerText(),
                  SizedBox(
                    height: 20.h,
                  ),
                  _buildSocialLoginOptions(),
                  SizedBox(
                    height: 25.h,
                  ),
                  RichTextWidget(
                    colorText: "Create Account",
                    function: () async {
                      if (!(await NetworkUtili.verifyInternetStatus())) {
                        Get.toNamed(AppRoutesName.signUpPage);
                      }
                    },
                    simpleText: "Don't Have An Account? ",
                  ),
                  SizedBox(
                    height: .12.sh,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSocialLoginOptions() {
    return Row(
      children: [
        Expanded(
          child: IconWithButtonWidget(
              function: () async {
                NetworkUtili.verifyInternetStatus();
              },
              color: AppColors.facebookBlue,
              image: AppIcons.facebookIcon,
              title: "Facebook"),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: IconWithButtonWidget(
              function: () async {
                if (!(await NetworkUtili.verifyInternetStatus())) {
                  await signInController.signWithGoogle();
                }
              },
              color: AppColors.red,
              image: AppIcons.gmailIcon,
              title: "Gmail"),
        ),
      ],
    );
  }

  Form _buildLoginForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormFieldWidget(
            hintText: 'Email Address',
            controller: signInController.emailET,
            validator: (emailText) {
              if (emailText!.isEmpty) {
                return 'Please enter your Email Address';
              } else if (!AppsFunction.isValidEmail(emailText)) {
                return 'Please Enter a Valid Email Address';
              }
              return null;
            },
            textInputType: TextInputType.emailAddress,
          ),
          TextFormFieldWidget(
            isShowPassword: true,
            obscureText: true,
            validator: (passwordText) {
              if (passwordText!.isEmpty) {
                return 'Please enter your Password';
              } else if (passwordText.length < 6) {
                return 'Password Must be geather then 6 Characteris';
              }
              return null;
            },
            hintText: "Password",
            controller: signInController.passwordET,
          ),
        ],
      ),
    );
  }

  Align _buildForgetPasswordButton() {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () async {
            if (!(await NetworkUtili.verifyInternetStatus())) {
              Get.toNamed(AppRoutesName.forgetPasswordPage);
              signInController.cleanTextField();
            }
          },
          child: Text("Forget Password",
              style: AppsTextStyle.forgetPasswordTextStyle),
        ));
  }

  Row _buildOrDividerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLine(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Text(
            "with Or",
            style: TextStyle(color: AppColors.grey),
          ),
        ),
        _buildLine(),
      ],
    );
  }

  Container _buildLine() {
    return Container(
      height: 2.5.h,
      width: 70.w,
      color: AppColors.grey,
    );
  }
}
