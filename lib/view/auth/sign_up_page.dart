import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/sign_up_controller.dart';
import '../../res/app_function.dart';
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
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        signUpController.clearField();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Material(
          color: AppColors.white,
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.h,
                    ),
                    _captureImageForProfile(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Registration",
                      style: GoogleFonts.poppins(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      "Check our fresh viggies from Jasim Grocery",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, color: AppColors.cardDarkColor),
                    ),
                    SizedBox(height: 45.h),
                    _buildSignUpForm(),
                    SizedBox(
                      height: 15.h,
                    ),
                    _buildSignUpButton(),
                    SizedBox(
                      height: 25.h,
                    ),
                    AppsFunction.buldRichText(
                        context: context,
                        simpleText: "Already Create An Account? ",
                        colorText: "Sign In",
                        function: () {
                          Get.back();
                          signUpController.clearField();
                        }),
                    SizedBox(
                      height: .22.sh,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Widget _captureImageForProfile() {
    return InkWell(
      onTap: () async {
        Get.bottomSheet(
            backgroundColor: AppColors.white, const SelectPhotoProfile());
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.grey, width: 3.w)),
        child: Obx(() {
          var imageFile =
              signUpController.selectImageController.selectPhoto.value;
          return CircleAvatar(
            radius: 0.2.sw,
            backgroundImage: imageFile == null ? null : FileImage(imageFile),
            backgroundColor: AppColors.backgroundLightColor,
            foregroundColor: AppColors.black,
            child: imageFile == null
                ? Icon(
                    Icons.add_photo_alternate,
                    size: 0.2.sw,
                    color: AppColors.grey,
                  )
                : null,
          );
        }),
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
            height: 10.h,
          ),
          IntlPhoneField(
            textInputAction: TextInputAction.done,
            controller: signUpController.phontET,
            style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor),
            decoration: AppsFunction.textFormFielddecoration(
                hintText: "Phone Number", function: () {}),
            languageCode: "en",
            validator: (phoneNumber) {
              if (phoneNumber == null || phoneNumber.completeNumber.isEmpty) {
                return 'Please enter a valid phone number';
              }
              if (phoneNumber.number.length < 10) {
                return 'Phone number is too short';
              }
              return null;
            },
            initialCountryCode: 'BD',
            onChanged: (phoneNumber) {},
            onCountryChanged: (country) {},
          ),
          SizedBox(
            height: 20.h,
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
