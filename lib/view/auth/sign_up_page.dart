import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../../res/app_function.dart';

import '../../res/app_string.dart';
import '../../res/valudation.dart';
import '../../widget/phone_number_widget.dart';
import 'widget/capture_image_profile_widget.dart';
import 'widget/custom_auth_button_widget.dart';
import '../../widget/rich_text_widget.dart';
import '../../widget/text_form_field_widget.dart';

import 'widget/auth_page_intro.dart';

/// `SignUpPage` is a user registration screen where users can enter their details
/// to create a new account.
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
      canPop: false, // Prevents Back when Loadng True
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
                  // Header with profile image picker and description
                  AuthIntroWidget(
                    customWidget: const ProfileImagePicker(),
                    title: AppString.registrationTitle,
                    description: AppString.authPageDescription,
                  ),

                  /// Displays the form.
                  _buildForm(),

                  AppsFunction.verticalSpacing(15),

                  /// Registration Button.
                  AuthButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      await authController.registerNewUser();
                    },
                    label: AppString.signUpTitle,
                  ),
                  AppsFunction.verticalSpacing(25),
                  RichTextWidget(
                    normalText: AppString.alreadyHaveAccount,
                    highlightedText: AppString.signInTitle,
                    onTap: () async {
                      if (!authController.loadingController.loading.value) {
                        Get.back();
                        authController.resetFields();
                      }
                    },
                  ),
                  AppsFunction.verticalSpacing(150)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build the sign-up form with various input fields and validations.
  Form _buildForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name input field
          CustomTextFormField(
            label: AppString.nameLabel,
            hintText: AppString.nameHint,
            controller: authController.nameController,
            validator: Validators.validateName, // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),

          // Email input field
          CustomTextFormField(
            label: AppString.emailLabel,
            hintText: AppString.emailHint,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          // Password input field
          CustomTextFormField(
            label: AppString.passwordLabel,
            obscureText: true,
            hasPasswordToggle: true,
            validator: Validators.validatePassword,
            hintText: AppString.passwordHint,
            textInputAction: TextInputAction.next,
            controller: authController.passwordController,
          ),

          // Confirm password input field
          CustomTextFormField(
            label: AppString.passwordConfirmLabel,
            obscureText: true,
            hasPasswordToggle: true,
            validator: (value) => Validators.validateConfirmPassword(
              value,
              authController.passwordController.text,
            ),
            hintText: AppString.confirmPasswordHint,
            controller: authController.confirmPasswordController,
          ),
          AppsFunction.verticalSpacing(10),
          // Phone number input field
          PhoneNumberWidget(
            controller: authController.phoneController,
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}

/*

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final authController = Get.find<AuthController>();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (!authController.loadingController.loading.value) {
          authController.clearInputFields();
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AuthPageIntro(
                    widget: const ProfileImagePickerWidget(),
                    title: AppString.adminRegistration,
                    description: AppString.logInPageSubjectTitle,
                  ),
                  _buildSignUpForm(),
                  AppsFunction.verticalSpacing(15),
                  CustomAuthButtonWidget(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;
                      await NetworkUtili.executeWithInternetCheck(
                          function: () async {
                        await authController.registerUser();
                      });
                    },
                    title: AppString.signup,
                  ),
                  AppsFunction.verticalSpacing(25),
                  RichTextWidget(
                    simpleText: AppString.alreadyCreateAccount,
                    colorText: AppString.signIn,
                    function: () async {
                      if (!authController.loadingController.loading.value) {
                        Get.back();
                        authController.clearInputFields();
                      }
                    },
                  ),
                  AppsFunction.verticalSpacing(150)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build the sign-up form with various input fields and validations.
  Form _buildSignUpForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWidget(
            label: AppString.name,
            hintText: AppString.yourName,
            controller: authController.nameController,
            validator: Validators.validateNonEmpty, // Validation method.
            textInputType: TextInputType.name, // Keyboard type.
          ),

          // Email
          TextFormFieldWidget(
            label: AppString.email,
            hintText: AppString.emailAddress,
            controller: authController.emailController,
            validator: Validators.validateEmail,
            textInputType: TextInputType.emailAddress,
          ),

          // Password
          TextFormFieldWidget(
            label: AppString.password,
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validatePassword,
            hintText: AppString.password,
            textInputAction: TextInputAction.next,
            controller: authController.passwordController,
          ),

          TextFormFieldWidget(
            label: AppString.passwordConfirm,
            obscureText: true,
            isShowPassword: true,
            validator: Validators.validateConfirmPassword,
            hintText: AppString.passwordConfirm,
            controller: authController.confirmPasswordController,
          ),
          AppsFunction.verticalSpacing(10),

          Text(AppString.phone, style: AppsTextStyle.labelTextStyle),
          AppsFunction.verticalSpacing(8),
          IntlPhoneField(
            textInputAction: TextInputAction.done,
            controller: authController.phoneController,
            style: AppsTextStyle.textFieldInputTextStyle(false),
            decoration: AppsFunction.textFormFielddecoration(
              hintText: AppString.phoneNumber,
              function: () {},
            ),
            languageCode: "en",
            initialCountryCode: 'BD',
          ),
          AppsFunction.verticalSpacing(20),
        ],
      ),
    );
  }
}

*/


/*
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
        onTap: () async {
          FocusScope.of(context).unfocus();
          NetworkUtili.verifyInternetStatus();
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
                    const CaptureImageProfileWidget(),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text("Registration",
                        style: AppsTextStyle.largeTitleTextStyle),
                    SizedBox(
                      height: 10.h,
                    ),
                    Text("Check our fresh viggies from Jasim Grocery",
                        style: AppsTextStyle.secondaryTextStyle),
                    SizedBox(height: 45.h),
                    _buildSignUpForm(),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomButtonWidget(
                      onPressed: () async {
                        if (!formKeySignUp.currentState!.validate()) return;
                        signUpController.createNewUserButton();
                      },
                      title: 'Sign Up',
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    RichTextWidget(
                        simpleText: "Already Create An Account? ",
                        colorText: "Sign In",
                        function: () async {
                          if (!(await NetworkUtili.verifyInternetStatus())) {
                            Get.back();
                            signUpController.clearField();
                          }
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
            style: AppsTextStyle.textFieldInputStyle(false),
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
}
*/