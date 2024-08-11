import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/sign_up_controller.dart';
import '../../res/app_function.dart';
import '../../res/appasset/icon_asset.dart';
import '../../res/constants.dart';
import '../../../res/app_colors.dart';

import '../../widget/text_form_field_widget.dart';
import '../../widget/select_photo_profile_widget.dart';
import 'widget/custom_button_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController signUpController = Get.find();

  final formKeySignUp = GlobalKey<FormState>();

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
                  horizontal: Get.width * .0444, vertical: Get.height * .024),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * .071,
                  ),
                  _captureImageForProfile(),
                  SizedBox(
                    height: Get.height * .018,
                  ),
                  Text(
                    "Registration",
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                  SizedBox(
                    height: Get.height * .012,
                  ),
                  Text(
                    "Check our fresh viggies from Jasim Grocery",
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: AppColors.cardDarkColor),
                  ),
                  SizedBox(height: Get.height * .059),
                  _buildSignUpForm(),
                  SizedBox(
                    height: Get.height * .018,
                  ),
                  _buildSignUpButton(),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  AppsFunction.buldRichText(
                      context: context,
                      simpleText: "Already Create An Account? ",
                      colorText: "Sign In",
                      function: () {
                        Get.back();
                      }),
                  SizedBox(
                    height: Get.height * .22,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Obx _captureImageForProfile() {
    return Obx(
      () => InkWell(
        onTap: () async {
          Get.bottomSheet(
              backgroundColor: AppColors.white, const SelectPhotoProfile());
        },
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.grey, width: 3)),
          child: CircleAvatar(
            radius: Get.width * .2,
            backgroundImage: signUpController.selectPhoto.value == null
                ? null
                : FileImage(signUpController.selectPhoto.value!),
            backgroundColor: AppColors.backgroundLightColor,
            foregroundColor: AppColors.black,
            child: signUpController.selectPhoto.value == null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: Get.width * .2,
                    color: AppColors.grey,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Form _buildSignUpForm() {
    return Form(
      key: formKeySignUp,
      child: Column(
        children: [
          TextFormFieldWidget(
            hintText: 'Enter Your Name',
            controller: signUpController.nameET,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
            textInputType: TextInputType.name,
          ),
          TextFormFieldWidget(
            hintText: 'Email Address',
            controller: signUpController.emailET,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Email Address';
              } else if (!AppsFunction.isValidEmail(value)) {
                return 'Please Enter a Valid Email Address';
              }
              return null;
            },
            textInputType: TextInputType.emailAddress,
          ),
          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Password';
              } else if (value.length < 6) {
                return 'Password Must be geather then 6 Characteris';
              }
              return null;
            },
            hintText: "Password",
            controller: signUpController.passwordET,
          ),
          TextFormFieldWidget(
            obscureText: true,
            isShowPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your Confirm Password';
              } else if (value.length < 6) {
                return 'Confirm Password Must be geather then 6 Characteris';
              }
              return null;
            },
            hintText: "Confirm Password",
            controller: signUpController.confirmpasswordET,
          ),
          SizedBox(
            height: Get.height * .012,
          ),
          IntlPhoneField(
            textInputAction: TextInputAction.done,
            controller: signUpController.phontET,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor),
            decoration: globalMethod.textFormFielddecoration(
                hintText: "Phone Number", function: () {}),
            languageCode: "en",
            initialCountryCode: 'BD',
            onChanged: (phone) {},
            onCountryChanged: (country) {},
          ),
          SizedBox(
            height: Get.height * .024,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
        width: Get.width,
        child: CustomButtonWidget(
          onPressed: () async {
            if (!formKeySignUp.currentState!.validate()) return;
            signUpController.createNewUserButton();
          },
          title: 'Sign Up',
        ));
  }
}
