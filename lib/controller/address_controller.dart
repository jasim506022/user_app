import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/address_model.dart';
import '../model/app_exception.dart';
import '../repository/address_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/constants.dart';
import '../res/routes/routes_name.dart';

class AddressController extends GetxController {
  final AddressRepository _addressRepository;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController flatHouseNumberTEC = TextEditingController();
  TextEditingController streetnameornumberTEC = TextEditingController();
  TextEditingController villageTEC = TextEditingController();
  TextEditingController cityTEC = TextEditingController();
  TextEditingController countryTEC = TextEditingController();

  void clearInputField() {
    nameTEC.clear();
    phoneTEC.clear();
    flatHouseNumberTEC.clear();
    streetnameornumberTEC.clear();
    villageTEC.clear();
    cityTEC.clear();
    countryTEC.clear();
    currentDropdownAddress.value = list[0];
  }

  AddressController(this._addressRepository);

  var currentDropdownAddress = list[0].obs;

  var completeAddress = "".obs;

  var addressid = "".obs;
  var currentAddressIndex = 0.obs;

  var length = 0.obs;

  setIndex(int index) {
    currentAddressIndex.value = index;
  }

  setLength(int index) {
    length.value = index;
  }

  setAddressId(String address) {
    addressid.value = address;
  }

  var id = "".obs;

  var isChange = false.obs;

  setDropdownAddress(String location) {
    currentDropdownAddress.value = location;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> addressSnapshot() {
    try {
      return _addressRepository.addressSnapshot();
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
      rethrow;
    }
  }

  void deleteAddress({required String addressId}) {
    try {
      _addressRepository.deleteAddress(addressId: addressId);
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    }
  }

  void addChangeListener() {
    final controllers = [
      nameTEC,
      phoneTEC,
      flatHouseNumberTEC,
      streetnameornumberTEC,
      villageTEC,
      cityTEC,
      countryTEC
    ];

    for (var textField in controllers) {
      textField.addListener(() {
        isChange.value = true;
      });
    }
  }

  // Save Address
  Future<void> saveAddress(bool isUpdate) async {
    if (!await _checkInternetConnection()) return;

    try {
      if (!isUpdate) {
        id.value = DateTime.now().millisecondsSinceEpoch.toString();
      }

      _buildCompleteAddress();
      AddressModel addressModel = _buildAddressModel();
      await _addressRepository.uploadOrUpdateAddress(
          addressModel: addressModel, isUpdate: isUpdate);
      clearInputField();
      isChange.value = false;
      Get.offNamed(RoutesName.billPage);
      AppsFunction.flutterToast(
          msg: isUpdate
              ? "Sucessfully Update"
              : "Successfully Upload a New Address");
    } catch (e) {
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    }
  }

  void updateFiled(AddressModel addressModel) {
    id.value = addressModel.addressId!;
    nameTEC.text = addressModel.name!;
    phoneTEC.text = addressModel.phone!;
    flatHouseNumberTEC.text = addressModel.flatno!;
    streetnameornumberTEC.text = addressModel.streetno!;
    villageTEC.text = addressModel.village!;
    cityTEC.text = addressModel.city!;
    countryTEC.text = addressModel.country!;
    currentDropdownAddress.value = addressModel.deliveryplace!;
    completeAddress.value = addressModel.completeaddress!;
  }

  Future<bool> _checkInternetConnection() async {
    if (await AppsFunction.internetChecking()) {
      AppsFunction.errorDialog(
        icon: IconAsset.warningIcon,
        title: "No Internet Connection",
        content: "Please check your internet settings and try again.",
        buttonText: "Okay",
      );
      return false;
    }
    return true;
  }

  void _buildCompleteAddress() {
    completeAddress.value = [
      flatHouseNumberTEC.text.trim(),
      streetnameornumberTEC.text.trim(),
      villageTEC.text.trim(),
      cityTEC.text.trim(),
      countryTEC.text.trim()
    ].join(", ");
  }

  AddressModel _buildAddressModel() {
    return AddressModel(
        addressId: id.value,
        city: cityTEC.text.trim(),
        completeaddress: completeAddress.value,
        country: countryTEC.text.trim(),
        deliveryplace: currentDropdownAddress.value,
        flatno: flatHouseNumberTEC.text.trim(),
        name: nameTEC.text.trim(),
        phone: phoneTEC.text.trim(),
        streetno: streetnameornumberTEC.text.trim(),
        village: villageTEC.text.trim());
  }

  @override
  void onClose() {
    nameTEC.dispose();
    phoneTEC.dispose();
    flatHouseNumberTEC.dispose();
    streetnameornumberTEC.dispose();
    villageTEC.dispose();
    cityTEC.dispose();
    countryTEC.dispose();
    super.onClose();
  }
}
