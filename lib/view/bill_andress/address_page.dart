import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controller/address_controller.dart';
import '../../model/address_model.dart';
import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import '../../res/constants.dart';
import '../../res/app_colors.dart';

import '../../widget/text_form_field_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  AddressController addressController = Get.find();

  late final bool isAddressUpdateMode;
  late final AddressModel? addressModel;

  @override
  void initState() {
    _initializeAddressDetails();

    super.initState();
  }

  void _initializeAddressDetails() {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      isAddressUpdateMode = arguments["isUpdate"] ?? false;
      addressModel = arguments["addressModel"];
      if (isAddressUpdateMode && addressModel != null) {
        addressController.updateFiled(addressModel!);
      }
    } else {
      isAddressUpdateMode = false;
    }
  }

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        _handleBackNavigaion(didPop);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            isAddressUpdateMode ? "Update Address " : "Add Address ",
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.greenColor,
            onPressed: () {
              if (!key.currentState!.validate()) return;
              addressController.saveAddress(isAddressUpdateMode);
            },
            icon: const Icon(Icons.update),
            label: Text(
              isAddressUpdateMode ? "Update" : "Save",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: ListView(
            children: [
              _buildAddressForm(),
              SizedBox(
                height: 350.h,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleBackNavigaion(bool didPop) {
    if (didPop) return;

    if (addressController.isChange.value == false) {
      Get.back();
    } else {
      AppsFunction.confirmationDialog(
        title: "Save Changed?",
        subTitle: 'do you want to save change?',
        yesFunction: () => Get.back(),
        noFunction: () {
          addressController.clearInputField();
          addressController.isChange.value = false;
          Get.back();
          Get.back();
        },
      );
    }
  }

  Form _buildAddressForm() {
    return Form(
      onChanged: () {},
      key: key,
      child: Column(
        children: [
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) => _validateName(value),
            controller: addressController.nameTEC,
            hintText: 'Name',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            validator: (value) => _validatePhoneNumber(value),
            controller: addressController.phoneTEC,
            hintText: 'Phone',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) =>
                _validateNotEmpty(value, "flat/house number."),
            controller: addressController.flatHouseNumberTEC,
            hintText: 'Flat/House Number',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) =>
                _validateNotEmpty(value, "Street number Or Name"),
            controller: addressController.streetnameornumberTEC,
            hintText: 'Street Number or name',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) => _validateNotEmpty(value, "Village Name"),
            controller: addressController.villageTEC,
            hintText: 'Village Name',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) => _validateNotEmpty(value, "City Name"),
            controller: addressController.cityTEC,
            hintText: 'City Name',
            textInputType: TextInputType.text,
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TextFormFieldWidget(
                  onChanged: (value) =>
                      _validateNotEmpty(value, "Country Name"),
                  controller: addressController.countryTEC,
                  hintText: 'Country Name',
                  textInputType: TextInputType.text,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Flexible(flex: 2, child: _buildDropdown())
            ],
          ),
        ],
      ),
    );
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) return "Please enter your name";
    if (value.length <= 2) return "Name must be longer than 2 characters";
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return "Please enter your phone number";
    if (value.length != 11) return "Phone number must be exactly 11 digits";
    return null;
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "Please enter your $fieldName.";
    return null;
  }

  Widget _buildDropdown() {
    return Obx(
      () => DropdownButton<String>(
        value: addressController.currentDropdownAddress.value,
        elevation: 16,
        style: AppsTextStyle.mediumText600.copyWith(color: AppColors.black),
        underline: Container(
          height: 2,
          color: AppColors.greenColor,
        ),
        onChanged: (String? value) {
          addressController.setDropdownAddress(value!);
          addressController.addChangeListener();
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppsTextStyle.smallestText.copyWith(fontSize: 14.sp),
            ),
          );
        }).toList(),
      ),
    );
  }
}
