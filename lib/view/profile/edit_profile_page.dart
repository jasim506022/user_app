import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:user_app/res/valudation.dart';

import '../../controller/profile_controller.dart';

import '../../res/app_colors.dart';
import '../../res/app_constant.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../widget/select_photo_profile_widget.dart';
import '../../widget/text_form_field_widget.dart';
import '../../res/network_utili.dart';
import 'widget/about_data_widget.dart';
import 'widget/row_text_title_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileController = Get.find<ProfileController>();

  late bool _isEditMode;
  var key = GlobalKey<FormState>();

  @override
  void initState() {
    _isEditMode = Get.arguments ?? false;
    profileController.getUserInformationSnapshot();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          profileController.handleBackNavigaion(didPop);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                _isEditMode ? AppString.editProfile : AppString.about,
              ),
              actions: [
                _isEditMode
                    ? IconButton(
                        onPressed: () async {
                          if (!key.currentState!.validate()) return;
                          if (!(await NetworkUtili.verifyInternetStatus())) {
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
                      AppsFunction.verticalSpacing(50),
                      _isEditMode ? _buildFormField() : const AboutDataWidget(),
                      AppsFunction.verticalSpacing(100),
                    ],
                  ),
                ))));
  }

  Widget _buildProfileImageSection() {
    return _isEditMode
        ? _editableProfileImage()
        : _profileImage(
            ClipOval(
              child: FancyShimmerImage(
                imageUrl: profileController.profileModel.value.imageurl ??
                    AppConstant.sharedPreference!
                        .getString(AppString.imageSharedPreference)!,
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
                      AppConstant.sharedPreference!
                          .getString(AppString.imageSharedPreference)!,
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
            // Get.bottomSheet(
            //     backgroundColor: AppColors.white, const SelectPhotoProfile());
            // profileController.isChange.value = true;
          },
          icon: Icon(
            Icons.camera_alt,
            color: AppColors.white,
            size: 30.h,
          )),
    );
  }

  _buildFormField() {
    return Form(
        key: key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowTextTitleWidget(icon: Icons.person, title: AppString.name),
            TextFormFieldWidget(
              onChanged: (value) => profileController.addChangeListener(),
              validator: Validators.validateName,
              controller: profileController.nameTEC,
              hintText: AppString.enterName,
            ),
            AppsFunction.verticalSpacing(15),
            RowTextTitleWidget(icon: Icons.phone, title: AppString.phone),
            AppsFunction.verticalSpacing(15),
            IntlPhoneField(
              textInputAction: TextInputAction.next,
              controller: profileController.phoneTEC,
              style: AppsTextStyle.textFieldInputStyle(true),
              decoration: AppsFunction.textFormFielddecoration(
                  hintText: AppString.enterPhone, function: () {}),
              languageCode: "en",
              initialCountryCode: 'BD',
              onChanged: (value) => profileController.addChangeListener(),
              onCountryChanged: (country) {},
            ),
            AppsFunction.verticalSpacing(15),
            const RowTextTitleWidget(icon: Icons.email, title: AppString.email),
            TextFormFieldWidget(
              controller: profileController.emailTEC,
              enabled: false,
              hintText: AppString.email,
            ),
            AppsFunction.verticalSpacing(15),
            const RowTextTitleWidget(
                icon: Icons.place, title: AppString.address),
            TextFormFieldWidget(
              validator: (value) {
                Validators.validateNotEmpty(value, AppString.address);
                return null;
              },
              onChanged: (p0) => profileController.addChangeListener(),
              hintText: AppString.hintAddress,
              controller: profileController.addressTEC,
            ),
          ],
        ));
  }
}
