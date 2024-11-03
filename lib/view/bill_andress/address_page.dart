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
      isUpdate = arguments["isUpdate"] ?? false;
      addressModel = arguments["addressModel"];
      if (isUpdate && addressModel != null) {
        addressController.updateFiled(addressModel!);
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
            isUpdate ? "Update Address " : "Add Address ",
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.greenColor,
            onPressed: () async {
              if (!_formKey.currentState!.validate()) return;
              if (!(await AppsFunction.verifyInternetStatus())) {
                addressController.saveAddress(isUpdate);
              }
            },
            icon: Icon(
              isUpdate ? Icons.update : Icons.save,
              color: AppColors.white,
            ),
            label: Text(isUpdate ? "Update" : "Save",
                style: AppsTextStyle.largeBoldText
                    .copyWith(color: AppColors.white))),
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

  List<Widget> _buildTextFields() {
    return [
      _buildTextField(addressController.nameTEC, 'Name', _validateName),
      _buildTextField(
          addressController.phoneTEC, 'Phone', _validatePhoneNumber),
      _buildTextField(addressController.flatHouseNumberTEC, 'Flat/House Number',
          (value) => _validateNotEmpty(value, "flat/house number")),
      _buildTextField(
          addressController.streetnameornumberTEC,
          'Street Number or Name',
          (value) => _validateNotEmpty(value, "Street number or name")),
      _buildTextField(addressController.villageTEC, 'Village Name',
          (value) => _validateNotEmpty(value, "Village Name")),
      _buildTextField(addressController.cityTEC, 'City Name',
          (value) => _validateNotEmpty(value, "City Name")),
    ];
  }

  TextFormFieldWidget _buildTextField(TextEditingController controller,
      String hintText, String? Function(String?)? validator) {
    return TextFormFieldWidget(
      onChanged: (p0) => addressController.addChangeListener(),
      validator: validator,
      controller: controller,
      hintText: hintText,
      textInputType: TextInputType.text,
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
              style: AppsTextStyle.mediumBoldText.copyWith(fontSize: 14.sp),
            ),
          );
        }).toList(),
      ),
    );
  }
}
