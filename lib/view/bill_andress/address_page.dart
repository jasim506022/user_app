import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/address_controller.dart';
import '../../model/address_model.dart';
import '../../res/app_function.dart';
import '../../res/app_string.dart';
import '../../res/apps_text_style.dart';
import '../../res/app_colors.dart';

import '../../res/valudation.dart';
import '../../widget/text_form_field_widget.dart';
import '../../res/network_utili.dart';
import 'widget/address_type.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  var addressController = Get.find<AddressController>();

  late final bool isUpdate;
  late final AddressModel? addressModel;

  @override
  void initState() {
    _initializeAddressDetails();

    super.initState();
  }

  void _initializeAddressDetails() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      isUpdate = arguments[AppString.isUpdate] ?? false;
      addressModel = arguments[AppString.addressModel];
      if (isUpdate && addressModel != null) {
        addressController.updateFields(addressModel!);
      }
    } else {
      isUpdate = false;
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        addressController.handleBackNavigaion(didPop);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            isUpdate ? AppString.updateAddress : AppString.addAddress,
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.accentGreen,
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;

              NetworkUtils.executeWithInternetCheck(action: () {
                addressController.saveAddress(isUpdate);
              });

/*
              if (!(await NetworkUtili.verifyInternetStatus())) {
                addressController.saveAddress(isUpdate);
              }
*/
            },
            icon: Icon(
              isUpdate ? Icons.update : Icons.save,
              color: AppColors.white,
            ),
            label: Text(isUpdate ? AppString.update : AppString.save,
                style: AppsTextStyle.mediumBoldText
                    .copyWith(color: AppColors.white))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListView(
            children: [
              _buildAddressForm(),
              AppsFunction.verticalSpacing(350),
            ],
          ),
        ),
      ),
    );
  }

  Form _buildAddressForm() {
    return Form(
      onChanged: () {},
      key: _formKey,
      child: Column(
        children: [
          ..._buildTextFields(),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: CustomTextFormField(
                  onChanged: (value) => addressController.addChangeListener(),
                  controller: addressController.countryTEC,
                  hintText: AppString.countryName,
                  textInputType: TextInputType.text,
                  // validator: (value) =>
                  //     Validators.validateNotEmpty(value, AppString.countryName),
                ),
              ),
              AppsFunction.horizontalSpacing(20),
              const Flexible(
                flex: 2,
                child: AddressType(),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _buildTextField(
        addressController.nameTEC, AppString.nameHintText,
        // Validators.validateName
      ),
      _buildTextField(
        addressController.phoneTEC, AppString.phoneHintText,
        // Validators.validatePhoneNumber
      ),
      _buildTextField(
        addressController.flatHouseNumberTEC,
        AppString.flatHintText,
        // (value) => Validators.validateNotEmpty(value, AppString.flatHintText),
      ),
      _buildTextField(
          addressController.streetnameornumberTEC, AppString.streetHintText
          // (value) => Validators.validateNotEmpty(value, AppString.streetHintText),
          ),
      _buildTextField(addressController.villageTEC, AppString.villageHintText
          // (value) =>
          //     Validators.validateNotEmpty(value, AppString.villageHintText),
          ),
      _buildTextField(addressController.cityTEC, AppString.cityNameHintText
          // (value) =>
          //     Validators.validateNotEmpty(value, AppString.cityNameHintText),
          ),
    ];
  }

  CustomTextFormField _buildTextField(
    TextEditingController controller,
    String hintText,
    // String? Function(String?)? validator
  ) {
    return CustomTextFormField(
      onChanged: (value) => addressController.addChangeListener(),
      // validator: validator,
      controller: controller,
      hintText: hintText,
      textInputType: TextInputType.text,
    );
  }

  // String? _validateName(String? value) {
  //   if (value == null || value.isEmpty) return "Please enter your name";
  //   if (value.length <= 2) return "Name must be longer than 2 characters";
  //   return null;
  // }

  // String? _validatePhoneNumber(String? value) {
  //   if (value == null || value.isEmpty) return "Please enter your phone number";
  //   if (value.length != 11) return "Phone number must be exactly 11 digits";
  //   return null;
  // }

  // String? _validateNotEmpty(String? value, String fieldName) {
  //   if (value == null || value.isEmpty) return "Please enter your $fieldName.";
  //   return null;
  // }
}
