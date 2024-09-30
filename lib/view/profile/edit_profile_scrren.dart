import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/utils.dart';

import '../../controller/profile_controller.dart';

import '../../res/app_colors.dart';
import '../../widget/select_photo_profile_widget.dart';
import '../../widget/text_form_field_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ProfileController profileController = Get.find();

  @override
  void initState() {
    isEdit = Get.arguments ?? false;
    profileController.getUserInformationSnapshot();
    super.initState();
  }

  bool isEdit = false;
  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        _handleBackNavigaion(didPop);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isEdit ? "Edit Profile" : "About",
          ),
          actions: [
            isEdit
                ? IconButton(
                    onPressed: () async {
                      if (!key.currentState!.validate()) return;

                      profileController.updateUserData();
                    },
                    icon:
                        Icon(Icons.done, color: Theme.of(context).primaryColor))
                : Container()
          ],
        ),
        body: Obx(
          () {
            if (profileController.loadingController.loading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        isEdit
                            ? Stack(
                                children: [
                                  Obx(() {
                                    final selectImage = profileController
                                        .selectImageController
                                        .selectPhoto
                                        .value;
                                    return _imageShape(
                                      child: CircleAvatar(
                                          backgroundImage: selectImage == null
                                              ? NetworkImage(profileController
                                                      .image.value)
                                                  as ImageProvider<Object>?
                                              : FileImage(selectImage)),
                                    );
                                  }),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: _selectImage(),
                                  ),
                                ],
                              )
                            : _imageShape(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      profileController.image.value),
                                ),
                              ),
                        SizedBox(
                          height: 50.h,
                        ),
                        _buildFormField(utils, context),
                        SizedBox(
                          height: 100.h,
                        ),
                      ],
                    ),
                  ));
            }
          },
        ),
      ),
    );
  }

  void _handleBackNavigaion(bool didPop) {
    if (didPop) return;

    if (profileController.isChange.value == false) {
      Get.back();
    } else {
      AppsFunction.confirmationDialog(
        title: "Save Changed?",
        content: 'do you want to save change?',
        yesFunction: () => Get.back(),
        noFunction: () {
          // addressController.clearInputField();
          profileController.isChange.value = false;
          Get.back();
          Get.back();
        },
      );
    }
  }

  _buildFormField(Utils utils, BuildContext context) {
    return Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _rowTextFileTitle(utils, Icons.person, "Name"),
            TextFormFieldWidget(
              onChanged: (value) => profileController.addChangeListener(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                if (value.length <= 2) {
                  return "Name must be longer than 2 characters";
                }
                return null;
              },
              controller: profileController.nameTEC,
              enabled: isEdit == false ? false : true,
              hintText: 'Enter Your Name',
            ),
            SizedBox(
              height: 15.h,
            ),
            _rowTextFileTitle(utils, Icons.phone, "Phone"),
            SizedBox(
              height: 15.h,
            ),
            IntlPhoneField(
              textInputAction: TextInputAction.next,
              controller: profileController.phoneTEC,
              style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isEdit
                      ? Theme.of(context).primaryColor
                      : utils.profileTextColor),
              decoration: AppsFunction.textFormFielddecoration(
                  hintText: "Phone Number", function: () {}),
              languageCode: "en",
              initialCountryCode: 'BD',
              enabled: true,
              onCountryChanged: (country) {},
            ),
            SizedBox(
              height: 15.h,
            ),
            _rowTextFileTitle(utils, Icons.email, "Email"),
            TextFormFieldWidget(
              controller: profileController.emailTEC,
              enabled: isEdit == false ? false : true,
              hintText: 'eamil',
            ),
            SizedBox(
              height: 15.h,
            ),
            _rowTextFileTitle(utils, Icons.place, "Address"),
            TextFormFieldWidget(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your Address";
                }

                return null;
              },
              onChanged: (p0) => profileController.addChangeListener(),
              hintText: "Enter Your Address",
              controller: profileController.addressTEC,
              enabled: isEdit == false ? false : true,
            ),
          ],
        ));
  }

  Container _selectImage() {
    return Container(
      decoration:
          BoxDecoration(color: Colors.red.shade400, shape: BoxShape.circle),
      child: IconButton(
          onPressed: () {
            Get.bottomSheet(
                backgroundColor: AppColors.white, const SelectPhotoProfile());
            profileController.isChange.value = true;
          },
          icon: Icon(
            Icons.camera_alt,
            color: AppColors.white,
            size: 30,
          )),
    );
  }

  Row _rowTextFileTitle(Utils utils, IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: utils.profileTextColor,
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: utils.profileTextColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Container _imageShape({required Widget child}) {
    return Container(
        height: 180,
        width: 180,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 2)),
        child: child);
  }
}
