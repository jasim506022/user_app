import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../res/routes/routesname.dart';
import '../res/constants.dart';
import '../res/gobalcolor.dart';
import '../../service/database/firebasedatabase.dart';

import '../../widget/show_error_dialog_widget.dart';
import '../../widget/textfieldformwidget.dart';
import '../service/provider/imageaddremoveprovider.dart';
import '../service/provider/loading_provider.dart';
import '../widget/loading_widget.dart';
import '../widget/select_photo_profile_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _phontET = TextEditingController();
  final TextEditingController _nameET = TextEditingController();
  final TextEditingController _emailET = TextEditingController();
  final TextEditingController _passwordET = TextEditingController();
  final TextEditingController _confirmpasswordET = TextEditingController();

  String? number;

  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<ImageAddRemoveProvider>(context, listen: false)
          ..setSingleImageXFile(singleImageXFile: null)
          ..setSingleImageUrl(singleImageUrl: "");
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _phontET.dispose();
    _nameET.dispose();
    _emailET.dispose();
    _passwordET.dispose();
    _confirmpasswordET.dispose();
    super.dispose();
  }

  Widget _buildSignUpButton(LoadingProvider loadingProvider,
      ImageAddRemoveProvider imageAddRemoveProvider, BuildContext context) {
    return SizedBox(
      width: mq.width,
      child: ElevatedButton(
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

                  String fileName =
                      "ju_grocery_${DateTime.now().millisecondsSinceEpoch}";

                  Reference storageRef = FirebaseDatabase.storageRef
                      .child("UserImage")
                      .child(fileName);

                  UploadTask uploadTask = storageRef.putFile(
                      File(imageAddRemoveProvider.singleImageXFile!.path));

                  TaskSnapshot taskSnapshot =
                      await uploadTask.whenComplete(() {});

                  taskSnapshot.ref.getDownloadURL().then((downloadurl) {
                    imageAddRemoveProvider.setSingleImageUrl(
                        singleImageUrl: downloadurl);
                  });

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
                  backgroundColor: white,
                ),
              )
            : Text(
                "Sign Up",
                style: GoogleFonts.poppins(
                    color: white, fontWeight: FontWeight.bold, fontSize: 14),
              ),
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
        color: white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * .0444, vertical: mq.height * .024),
            child: Consumer<ImageAddRemoveProvider>(
              builder: (context, imageAddRemoveProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mq.height * .071,
                    ),
                    InkWell(
                      onTap: () async {
                        showModalBottomSheet(
                          backgroundColor: white,
                          context: context,
                          builder: (context) {
                            return SelectPhotoProfile(
                              imagePicker: _picker,
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: grey, width: 3)),
                        child: CircleAvatar(
                          radius: mq.width * .2,
                          backgroundImage:
                              imageAddRemoveProvider.singleImageXFile == null
                                  ? null
                                  : FileImage(File(imageAddRemoveProvider
                                      .singleImageXFile!.path)),
                          backgroundColor: backgroundLightColor,
                          foregroundColor: black,
                          child: imageAddRemoveProvider.singleImageXFile == null
                              ? Icon(
                                  Icons.add_photo_alternate,
                                  size: mq.width * .2,
                                  color: grey,
                                )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .018,
                    ),
                    Text(
                      "Registration",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: black),
                    ),
                    SizedBox(
                      height: mq.height * .012,
                    ),
                    Text(
                      "Check our fresh viggies from Jasim Grocery",
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: cardDarkColor),
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
                              } else if (globalMethod.isValidEmail(value) ==
                                  false) {
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
                    Consumer<LoadingProvider>(
                      builder: (context, loadingProvider, child) {
                        return _buildSignUpButton(
                            loadingProvider, imageAddRemoveProvider, context);
                      },
                    ),
                    SizedBox(
                      height: mq.height * .03,
                    ),
                    globalMethod.buldRichText(
                        context: context,
                        simpleText: "Already Create An Account? ",
                        colorText: "Sign In",
                        function: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.signPage);
                        }),
                    SizedBox(
                      height: mq.height * .12,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
