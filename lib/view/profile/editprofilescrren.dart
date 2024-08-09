import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
// ignore: unused_import
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:user_app/res/utils.dart';

import '../../res/app_function.dart';
import '../../res/constants.dart';

import '../../res/app_colors.dart';
import '../../model/profilemodel.dart';
import '../../widget/textfieldformwidget.dart';
import '../main/main_page.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.isEdit});

  final bool isEdit;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();

  bool uploading = false;
  String image = "";
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;

  bool isChangeProfilePicture = false;

  getImageFromGaller() async {
    imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      isChangeProfilePicture = true;
      imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEdit ? "Edit Profile" : "Profile",
        ),
        actions: [
          widget.isEdit == true
              ? IconButton(
                  onPressed: () async {
                    if (isChangeProfilePicture) {
                      String fileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      Reference storageRef = FirebaseStorage.instance
                          .ref()
                          .child("userImage")
                          .child(fileName);
                      UploadTask uploadTask =
                          storageRef.putFile(File(imageFile!.path));

                      TaskSnapshot taskSnapshot =
                          await uploadTask.whenComplete(() {});
                      taskSnapshot.ref.getDownloadURL().then((downloadurl) {
                        image = downloadurl;
                      });

                      await FirebaseFirestore.instance
                          .collection("seller")
                          .doc(sharedPreference!.getString("uid"))
                          .update({
                        "name": nameTEC.text,
                        "email": emailTEC.text,
                        "address": addressTEC.text,
                        "phone": phoneTEC.text,
                        "imageurl": image,
                      }).then((value) {
                        AppsFunction.flutterToast(msg: "Bangladesh");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ));
                      }).catchError((error) {
                        AppsFunction.flutterToast(msg: "Error $error");
                      });
                    } else {
                      await FirebaseFirestore.instance
                          .collection("seller")
                          .doc(sharedPreference!.getString("uid"))
                          .update({
                        "name": nameTEC.text,
                        "email": emailTEC.text,
                        "address": addressTEC.text,
                        "phone": phoneTEC.text,
                      }).then((value) {
                        AppsFunction.flutterToast(msg: "indian");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ));
                      }).catchError((error) {
                        AppsFunction.flutterToast(msg: "Error $error");
                      });
                    }
                  },
                  icon: Icon(Icons.done, color: Theme.of(context).primaryColor))
              : Container()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(sharedPreference!.getString("uid"))
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                ProfileModel profileModel =
                    ProfileModel.fromMap(snapshot.data!.data()!);
                nameTEC.text = profileModel.name!;
                emailTEC.text = profileModel.email!;
                addressTEC.text = profileModel.address!;
                phoneTEC.text = profileModel.phone!;
                image = profileModel.imageurl!;
                return Column(
                  children: [
                    widget.isEdit == true
                        ? Stack(
                            children: [
                              Container(
                                height: 180,
                                width: 180,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 3)),
                                child: imageFile == null
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(image),
                                      )
                                    : CircleAvatar(
                                        backgroundImage:
                                            FileImage(File(imageFile!.path)),
                                      ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade400,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                      onPressed: () {
                                        getImageFromGaller();
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: AppColors.white,
                                        size: 30,
                                      )),
                                ),
                              ),
                            ],
                          )
                        : Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: AppColors.red, width: 2)),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(image),
                            ),
                          ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: utils.profileTextColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Name",
                          style: GoogleFonts.poppins(
                            color: utils.profileTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    TextFieldFormWidget(
                      controller: nameTEC,
                      enabled: widget.isEdit == false ? false : true,
                      hintText: 'f',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: utils.profileTextColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Phone",
                          style: GoogleFonts.poppins(
                            color: utils.profileTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    widget.isEdit == false
                        ? Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            height: 58,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).canvasColor,
                                    width: 1),
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Text("+88${profileModel.phone!}",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: utils.profileTextColor,
                                )),
                          )
                        : TextFieldFormWidget(
                            controller: phoneTEC,
                            enabled: widget.isEdit == false ? false : true,
                            hintText: '',
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: utils.profileTextColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Email",
                          style: GoogleFonts.poppins(
                            color: utils.profileTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    TextFieldFormWidget(
                      controller: emailTEC,
                      enabled: false,
                      hintText: 'hello',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          color: utils.profileTextColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Address",
                          style: GoogleFonts.poppins(
                            color: utils.profileTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                    TextFieldFormWidget(
                      hintText: "Hello",
                      controller: addressTEC,
                      enabled: widget.isEdit == false ? false : true,
                    ),
                  ],
                );
              }
              return const Text("No Bangladesh");
            },
          ),
        ),
      ),
    );
  }
}
