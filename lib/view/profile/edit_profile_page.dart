import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../controller/profile_controller.dart';

import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import '../../res/constant/string_constant.dart';
import '../../res/constants.dart';
import '../../res/utils.dart';
import '../../widget/select_photo_profile_widget.dart';
import '../../widget/text_form_field_widget.dart';
import 'widget/about_data_widget.dart';
import 'widget/row_text_title_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileController = Get.find<ProfileController>();

  late bool isEdit;
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    isEdit = Get.arguments ?? false;
    profileController.getUserInformationSnapshot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils();
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          profileController.handleBackNavigaion(didPop);
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
                          if (!(await AppsFunction.verifyInternetStatus())) {
                            profileController.updateUserData();
                          }
                        },
                        icon: Icon(Icons.done,
                            color: Theme.of(context).primaryColor))
                    : Container()
              ],
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildProfileImageSection(),
                      SizedBox(
                        height: 50.h,
                      ),
                      isEdit ? _buildFormField(utils) : const AboutDataWidget(),
                      SizedBox(
                        height: 100.h,
                      ),
                    ],
                  ),
                ))));
  }

  Widget _buildProfileImageSection() {
    return isEdit
        ? _editableProfileImage()
        : _profileImage(
            ClipOval(
              child: FancyShimmerImage(
                imageUrl: profileController.profileModel.value.imageurl ??
                    sharedPreference!
                        .getString(StringConstant.imageSharedPreference)!,
              ),
            ),
          );
  }

  Widget _editableProfileImage() {
    return Stack(
      children: [
        Obx(() {
          final image =
              profileController.selectImageController.selectPhoto.value;
          return _profileImage(image == null
              ? ClipOval(
                  child: FancyShimmerImage(
                  imageUrl: profileController.profileModel.value.imageurl ??
                      sharedPreference!
                          .getString(StringConstant.imageSharedPreference)!,
                ))
              : CircleAvatar(backgroundImage: FileImage(image)));
        }),
        Positioned(bottom: 5, right: 5, child: _selectImage()),
      ],
    );
  }

  Container _profileImage(Widget child) {
    return Container(
        height: 180.h,
        width: 180.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.red, width: 2)),
        child: child);
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
            size: 30.h,
          )),
    );
  }

  _buildFormField(Utils utils) {
    return Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const RowTextTitleWidget(icon: Icons.person, title: "Name"),
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
              hintText: 'Enter Your Name',
            ),
            SizedBox(
              height: 15.h,
            ),
            const RowTextTitleWidget(icon: Icons.phone, title: "Phone"),
            SizedBox(
              height: 15.h,
            ),
            IntlPhoneField(
              textInputAction: TextInputAction.next,
              controller: profileController.phoneTEC,
              style: AppsTextStyle.textFieldInputTextStyle(true),
              decoration: AppsFunction.textFormFielddecoration(
                  hintText: "Phone Number", function: () {}),
              languageCode: "en",
              initialCountryCode: 'BD',
              onChanged: (value) => profileController.addChangeListener(),
              onCountryChanged: (country) {},
            ),
            SizedBox(
              height: 15.h,
            ),
            const RowTextTitleWidget(icon: Icons.email, title: "Email"),
            TextFormFieldWidget(
              controller: profileController.emailTEC,
              enabled: false,
              hintText: 'eamil',
            ),
            SizedBox(
              height: 15.h,
            ),
            const RowTextTitleWidget(icon: Icons.place, title: "Address"),
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
            ),
          ],
        ));
  }
}

