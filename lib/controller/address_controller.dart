import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/model/address_model.dart';
import 'package:user_app/model/app_exception.dart';
import 'package:user_app/res/constants.dart';

import '../repository/address_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/routes/routesname.dart';

class AddressController extends GetxController {
  final AddressRepository _addressRepository;

  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController flatHouseNumberTEC = TextEditingController();
  TextEditingController streetnameornumberTEC = TextEditingController();
  TextEditingController villageTEC = TextEditingController();
  TextEditingController cityTEC = TextEditingController();
  TextEditingController countryTEC = TextEditingController();
  AddressController(this._addressRepository);

  var dropdownValue = list[0].obs;
  var completeAdddress = "".obs;

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

  void markAsChange() {
    isChange.value = true;
  }

  changeAddress(String values) {
    dropdownValue.value = values;
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

  deleteAddress({required String addressId}) {
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
        markAsChange();
      });
    }
  }

  uploadAndUpdateAddress(bool isUpdate) async {
    bool checkInternet = await AppsFunction.internetChecking();

    if (checkInternet) {
      AppsFunction.errorDialog(
          icon: IconAsset.warningIcon,
          title: "No Internet Connection",
          content: "Please check your internet settings and try again.",
          buttonText: "Okay");
    } else {
      try {
        if (!isUpdate) {
          id.value = DateTime.now().millisecondsSinceEpoch.toString();
        }
        completeAdddress.value =
            "${flatHouseNumberTEC.text.trim()}, ${streetnameornumberTEC.text.trim()}, ${villageTEC.text.trim()}, ${cityTEC.text.trim()}, ${countryTEC.text.trim()}";

        AddressModel addressModel = AddressModel(
            addressId: id.value,
            city: cityTEC.text.trim(),
            completeaddress: completeAdddress.value,
            country: countryTEC.text.trim(),
            deliveryplace: dropdownValue.value,
            flatno: flatHouseNumberTEC.text.trim(),
            name: nameTEC.text.trim(),
            phone: phoneTEC.text.trim(),
            streetno: streetnameornumberTEC.text.trim(),
            village: villageTEC.text.trim());

        await _addressRepository.uploadOrUpdateAddress(
            addressModel: addressModel, isUpdate: isUpdate);

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
  }

  @override
  void onInit() {
    isChange.value = false;
    super.onInit();
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
