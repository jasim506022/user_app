import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/auth/widget/app_sign_page_intro.dart';
import 'package:user_app/controller/login_controller.dart';
import 'package:user_app/res/app_function.dart';

import '../controller/loading_controller.dart';
import '../res/routes/routesname.dart';
import '../res/constants.dart';
import '../res/app_colors.dart';
import '../widget/loading_widget.dart';
import '../widget/textfieldformwidget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _passwordET = TextEditingController();
  final TextEditingController _emailET = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginController loginController = Get.put(LoginController(
    Get.find(),
  ));

  @override
  void didChangeDependencies() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _passwordET.dispose();
    _emailET.dispose();
    super.dispose();
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
                horizontal: mq.width * .044, vertical: mq.width * .024),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const AppSignInPageIntro(title: "Welcome Back!"),
                _buildLoginForm(),
                const SizedBox(
                  height: 5,
                ),
                _buildForgetPasswordButton(),
                SizedBox(height: mq.height * .02),
                _buildLoginButton(),
                SizedBox(
                  height: mq.height * .03,
                ),
                _buildOrDividerText(),
                SizedBox(
                  height: mq.height * .024,
                ),
                _buildSocialLoginOptions(context),
                SizedBox(
                  height: mq.height * .03,
                ),
                _buildCreateAccount(context),
                SizedBox(
                  height: mq.height * .12,
                ),
              ],
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
              function: () {
                // User For Facebook . I already use in User
              },
              color: AppColors.facebookColor,
              image: "asset/image/facebook.png",
              title: "Facebook"),
        ),
        SizedBox(
          width: mq.width * .0444,
        ),
        Expanded(
          child: _buildSocialLoginButton(
              function: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LoadingWidget(
                        message: "Loading for sign with Gmail");
                  },
                );
                bool checkInternet = await AppsFunction.internetChecking();

                if (checkInternet) {
                  AppsFunction.errorDialog(
                      icon: "asset/image/fruits.png",
                      title: "No Internet",
                      content: "Ever this is okay",
                      buttonText: "Okay");
                } else {
                  await loginController.signWithGoogle();
                }
              },
              color: AppColors.red,
              image: "asset/image/gmail.png",
              title: "Gmail"),
        ),
      ],
    );
  }

  Form _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFieldFormWidget(
            hintText: 'Email Address',
            controller: _emailET,
            validator: (emailText) {
              if (emailText!.isEmpty) {
                return 'Please enter your Email Address';
              } else if (!globalMethod.isValidEmail(emailText)) {
                return 'Please Enter a Valid Email Address';
              }
              return null;
            },
            textInputType: TextInputType.emailAddress,
          ),
          TextFieldFormWidget(
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
            controller: _passwordET,
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

      // What is different Between Function and Void Callbackfund and Difference
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
        height: mq.height * 0.071,
        width: mq.width,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: mq.height * .041,
                width: mq.height * .041,
                color: AppColors.white,
              ),
              SizedBox(
                width: mq.width * .033,
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
          padding: EdgeInsets.symmetric(horizontal: mq.width * .033),
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
      height: mq.height * .003,
      width: mq.width * .156,
      color: AppColors.grey,
    );
  }

  SizedBox _buildLoginButton() {
    return SizedBox(
      width: mq.width,
      child: CoustomButtonWidget(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) return;

          bool checkInternet = await AppsFunction.internetChecking();

          if (checkInternet) {
            AppsFunction.errorDialog(
                icon: "asset/image/fruits.png",
                title: "No Internet",
                content: "Ever this is okay",
                buttonText: "Okay");
          } else {
            loginController.signInWithEmailAndPassword(
                email: _emailET.text, password: _passwordET.text);
          }
        },
      ),
    );
  }

  RichText _buildCreateAccount(BuildContext context) {
    return globalMethod.buldRichText(
      colorText: "Create Account",
      context: context,
      function: () {
        Get.toNamed(RoutesName.signupPage);

        _passwordET.clear();
        _emailET.clear();
      },
      simpleText: "Don't Have An Account? ",
    );
  }
}

class CoustomButtonWidget extends StatelessWidget {
  const CoustomButtonWidget({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    LoadingController loadingController = Get.put(LoadingController());
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: mq.width * 0.022, vertical: mq.height * 0.018),
        ),
        onPressed: onPressed,
        child: Obx(
          () => loadingController.loading.value
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.white,
                  ),
                )
              : Text(
                  "Sign In",
                  style: GoogleFonts.poppins(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
        ));
  }
}
