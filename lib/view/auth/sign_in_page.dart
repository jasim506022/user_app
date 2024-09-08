import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/network_controller.dart';
import '../../controller/sign_in_controller.dart';
import '../../res/app_function.dart';
import '../../res/appasset/icon_asset.dart';
import '../../res/routes/routesname.dart';
import '../../res/app_colors.dart';
import '../../widget/text_form_field_widget.dart';
import 'widget/app_sign_page_intro.dart';
import 'widget/custom_button_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInController loginController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showInternetDialog();
    });
    super.initState();
  }

  showInternetDialog() async {
    bool checkInternet = await AppsFunction.internetChecking();

    if (checkInternet) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    }
  }

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    DependencyInjection.init();
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await AppsFunction.showBackDialog() ?? false;
        
        if (shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                    title: "Welcome Back!",
                    subTitle: "Check our fresh viggies from Jasim Grocery",
                  ),
                  _buildLoginForm(),
                  const SizedBox(
                    height: 5,
                  ),
                  _buildForgetPasswordButton(),
                  SizedBox(height: Get.height * .02),
                  _buildLoginButton(),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  _buildOrDividerText(),
                  SizedBox(
                    height: Get.height * .024,
                  ),
                  _buildSocialLoginOptions(context),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  _buildCreateAccount(context),
                  SizedBox(
                    height: Get.height * .12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildSocialLoginOptions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildSocialLoginButton(
              function: () {},
              color: AppColors.facebookColor,
              image: IconAsset.facebookIcon,
              title: "Facebook"),
        ),
        SizedBox(
          width: Get.width * .0444,
        ),
        Expanded(
          child: _buildSocialLoginButton(
              function: () async {
                await loginController.signWithGoogle();
              },
              color: AppColors.red,
              image: IconAsset.gmailIcon,
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
            controller: loginController.emailET,
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
            controller: loginController.passwordET,
          ),
        ],
      ),
    );
  }

  Align _buildForgetPasswordButton() {
    return Align(
        alignment: Alignment.topRight,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.forgetPassword);
          },
          child: Text(
            "Forget Password",
            style: GoogleFonts.poppins(
                color: AppColors.hintLightColor, fontWeight: FontWeight.w700),
          ),
        ));
  }

  InkWell _buildSocialLoginButton(
      {required Function function,
      required Color color,
      required String image,
      required String title}) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        height: Get.height * 0.071,
        width: Get.width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: Get.height * .041,
                width: Get.height * .041,
                color: AppColors.white,
              ),
              SizedBox(
                width: Get.width * .033,
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildOrDividerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildLine(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .033),
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
      height: Get.height * .003,
      width: Get.width * .156,
      color: AppColors.grey,
    );
  }

  SizedBox _buildLoginButton() {
    return SizedBox(
      width: Get.width,
      child: CustomButtonWidget(
        onPressed: () async {
          if (!formKey.currentState!.validate()) return;
          loginController.signInWithEmailAndPassword();
        },
        title: 'Sign In',
      ),
    );
  }

  RichText _buildCreateAccount(BuildContext context) {
    return AppsFunction.buldRichText(
      colorText: "Create Account",
      context: context,
      function: () {
        Get.toNamed(RoutesName.signupPage);
      },
      simpleText: "Don't Have An Account? ",
    );
  }
}
