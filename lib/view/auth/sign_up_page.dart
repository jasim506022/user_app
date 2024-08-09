import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/signup_controller.dart';
import '../../res/app_function.dart';
import '../../res/constants.dart';
import '../../../res/app_colors.dart';

import '../../../widget/textfieldformwidget.dart';
import 'widget/custom_button_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // SignUpController signUpController = Get.put(SignUpController(
  //   Get.find(),
  // ));

  // SignUpController signUpController = Get.put(SignUpController());
  SignUpController signUpController = Get.find();

  final TextEditingController _phontET = TextEditingController();
  final TextEditingController _nameET = TextEditingController();
  final TextEditingController _emailET = TextEditingController();
  final TextEditingController _passwordET = TextEditingController();
  final TextEditingController _confirmpasswordET = TextEditingController();

  String? number;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phontET.dispose();
    _nameET.dispose();
    _emailET.dispose();
    _passwordET.dispose();
    _confirmpasswordET.dispose();
    super.dispose();
  }

  Widget _buildSignUpButton() {
    return SizedBox(
        width: mq.width,
        child: CustomButtonWidget(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            if (_passwordET.text.trim() != _confirmpasswordET.text.trim()) {
              AppsFunction.errorDialog(
                  icon: "asset/image/fruits.png",
                  title: "Please Check Password",
                  content:
                      "Password and Confirm Password Is Not Match. Please Check Password",
                  buttonText: "Okay");
              return;
            }

            bool checkInternet = await AppsFunction.internetChecking();

            if (checkInternet) {
              AppsFunction.errorDialog(
                  icon: "asset/image/fruits.png",
                  title: "No Internet",
                  content: "No Internet",
                  buttonText: "Okay");
            } else {
              // signUpController.createNewUser(
              //     name: _emailET.text,
              //     phone: "0${_phontET.text}",
              //     email: _emailET.text,
              //     password: _passwordET.text);
            }
          },
        ));
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
                  horizontal: mq.width * .0444, vertical: mq.height * .024),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: mq.height * .071,
                  ),
                  /*
                  Obx(
                    () => InkWell(
                      onTap: () async {
                        Get.bottomSheet(
                            backgroundColor: AppColors.white,
                            const SelectPhotoProfile()
                            // colo: AppColors.white

                            );
/*
                        showModalBottomSheet(
                          backgroundColor: ,
                          context: context,
                          builder: (context) {
                            return const SelectPhotoProfile();
                          },
                        );
                        */
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.grey, width: 3)),
                        /*
                        child: CircleAvatar(
                          radius: mq.width * .2,
                          backgroundImage: signUpController.selectPhoto.value ==
                                  null
                              // imageAddRemoveProvider.singleImageXFile == null
                              ? null
                              : FileImage(signUpController.selectPhoto.value!),
                          backgroundColor: AppColors.backgroundLightColor,
                          foregroundColor: AppColors.black,
                          child: signUpController.selectPhoto.value == null
                              ? Icon(
                                  Icons.add_photo_alternate,
                                  size: mq.width * .2,
                                  color: AppColors.grey,
                                )
                              : null,
                        ),
                        */
                      ),

                      /*
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.grey, width: 3)),
                        child: CircleAvatar(
                          radius: mq.width * .2,
                          backgroundImage:
                              imageAddRemoveProvider.singleImageXFile == null
                                  ? null
                                  : FileImage(File(imageAddRemoveProvider
                                      .singleImageXFile!.path)),
                          backgroundColor: AppColors.backgroundLightColor,
                          foregroundColor: AppColors.black,
                          child: imageAddRemoveProvider.singleImageXFile == null
                              ? Icon(
                                  Icons.add_photo_alternate,
                                  size: mq.width * .2,
                                  color: AppColors.grey,
                                )
                              : null,
                        ),
                      ),
                      */
                    ),
                  ),
                 */
                  SizedBox(
                    height: mq.height * .018,
                  ),
                  Text(
                    "Registration",
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black),
                  ),
                  SizedBox(
                    height: mq.height * .012,
                  ),
                  Text(
                    "Check our fresh viggies from Jasim Grocery",
                    style: GoogleFonts.poppins(
                        fontSize: 16, color: AppColors.cardDarkColor),
                  ),
                  SizedBox(height: mq.height * .059),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldFormWidget(
                          hintText: 'Md Jasim Uddin',
                          controller: _nameET,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          textInputType: TextInputType.name,
                        ),
                        TextFieldFormWidget(
                          hintText: 'Email Address',
                          controller: _emailET,
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
                        TextFieldFormWidget(
                          obscureText: true,
                          isShowPassword: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Password';
                            }
                            return null;
                          },
                          hintText: "Password",
                          controller: _passwordET,
                        ),
                        TextFieldFormWidget(
                          obscureText: true,
                          isShowPassword: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Confirm Password';
                            }
                            return null;
                          },
                          hintText: "Confirm Password",
                          controller: _confirmpasswordET,
                        ),
                        SizedBox(
                          height: mq.height * .012,
                        ),
                        IntlPhoneField(
                          controller: _phontET,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor),
                          decoration: globalMethod.textFormFielddecoration(
                              hintText: "Phone Number", function: () {}),
                          languageCode: "en",
                          initialCountryCode: 'BD',
                          onChanged: (phone) {
                            number = phone.completeNumber;
                            setState(() {});
                          },
                          onCountryChanged: (country) {},
                        ),
                        SizedBox(
                          height: mq.height * .024,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .018,
                  ),
                  _buildSignUpButton(),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  AppsFunction.buldRichText(
                      context: context,
                      simpleText: "Already Create An Account? ",
                      colorText: "Sign In",
                      function: () {
                        Get.back();
                      }),
                  SizedBox(
                    height: mq.height * .12,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}



        /*
      ElevatedButton(
        style: globalMethod.elevateButtonStyle(),
        onPressed: () async {
          if (imageAddRemoveProvider.singleImageXFile == null) {
            globalMethod.flutterToast(msg: 'Please Select An Image');
            return;
          }

          if (!_formKey.currentState!.validate()) return;

          if (_passwordET.text.trim() == _confirmpasswordET.text.trim()) {
            {
              showDialog(
                context: context,
                builder: (context) {
                  return const LoadingWidget(message: "Registration......");
                },
              );
              try {
                final result = await InternetAddress.lookup('google.com');

                if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                  loadingProvider.setLoading(loading: true);

                  /*
                  String fileName =
                      "ju_grocery_${DateTime.now().millisecondsSinceEpoch}";

                  Reference storageRef = FirebaseDatabase.storageRef
                      .child("UserImage")
                      .child(fileName);

                  UploadTask uploadTask = storageRef.putFile(
                      File(imageAddRemoveProvider.singleImageXFile!.path));

                  TaskSnapshot taskSnapshot =
                      await uploadTask.whenComplete(() {});

              var iamge =    taskSnapshot.ref.getDownloadURL();
                  
                  // .then((downloadurl) {
                  //   imageAddRemoveProvider.setSingleImageUrl(
                  //       singleImageUrl: downloadurl);
                  // });

                  await FirebaseDatabase.createUserWithEmilandPaswordSnaphsot(
                    email: _emailET.text,
                    password: _passwordET.text,
                  ).then((user) async {
                    await FirebaseDatabase.createUserByEmailPassword(
                        image: imageAddRemoveProvider.singleImageUrl,
                        name: _nameET.text.trim(),
                        phone: _phontET.text.trim(),
                        userCredential: user);
                  }).then((value) {
                    loadingProvider.setLoading(loading: false);
                  });
*/
                  if (mounted) {
                    globalMethod.flutterToast(msg: "Successfully Register");
                    Navigator.pushReplacementNamed(
                        context, RoutesName.signPage);
                  }
                } else {
                  globalMethod.flutterToast(msg: "No Internet Connection");
                }
              } on SocketException {
                if (mounted) {
                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return const ShowErrorDialogWidget(
                        message:
                            "No Internect Connection. Please your Interenet Connection",
                        title: 'No Internet Connection',
                      );
                    },
                  );
                }

                loadingProvider.setLoading(loading: false);
              } on FirebaseAuthException catch (e) {
                if (mounted) {
                  globalMethod.handleError(context, e, loadingProvider);
                }
              } catch (e) {
                if (mounted) {
                  Navigator.pop(context);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return ShowErrorDialogWidget(
                          message: e.toString(), title: 'Error Occured');
                    },
                  );
                }

                loadingProvider.setLoading(loading: false);
              }
            }
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return const ShowErrorDialogWidget(
                    message:
                        "Password and Confirm Password Is Not Match. Please Check Password",
                    title: 'Please Check Password');
              },
            );
          }
        },
        child: loadingProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.white,
                ),
              )
            : Text(
                "Sign Up",
                style: GoogleFonts.poppins(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
      ),
   
   */

