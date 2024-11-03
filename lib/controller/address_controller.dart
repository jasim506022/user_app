import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/widget/loading_widget.dart';

import '../model/address_model.dart';
import '../model/app_exception.dart';
import '../repository/address_repository.dart';
import '../res/app_function.dart';
import '../res/appasset/icon_asset.dart';
import '../res/constants.dart';
import '../res/routes/routes_name.dart';
import '../widget/show_alert_dialog_widget.dart';

class AddressController extends GetxController {
  final AddressRepository repository;

  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController flatHouseNumberTEC = TextEditingController();
  final TextEditingController streetnameornumberTEC = TextEditingController();
  final TextEditingController villageTEC = TextEditingController();
  final TextEditingController cityTEC = TextEditingController();
  final TextEditingController countryTEC = TextEditingController();

  var currentDropdownAddress = list.first.obs;
  var completeAddress = "".obs;
  var addressid = "".obs;
  var currentAddressIndex = 0.obs;
  var length = 0.obs;
  var id = "".obs;
  var isChange = false.obs;

  AddressController(this.repository);

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

  void handleBackNavigaion(bool didPop) {
    if (didPop) return;

    if (isChange.value == false) {
      Get.back();
    } else {
      Get.dialog(CustomAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: "Save Changed?",
        subTitle: 'do you want to save change?',
        yesOnPress: () => Get.back(),
        noOnPress: () {
          clearInputField();
          isChange.value = false;
          Get.close(2);
        },
      ));
    }
  }

  setIndex(int index) {
    currentAddressIndex.value = index;
  }

 

  setAddressId(String address) {
    addressid.value = address;
  }

  void setDropdownAddress(String location) {
    currentDropdownAddress.value = location;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> addressSnapshot() {
    try {
      return repository.addressSnapshot();
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
      repository.deleteAddress(addressId: addressId);
      Get.back();
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
    try {
      LoadingWidget(
        message: isUpdate ? "Update Address" : "Upload a New Address",
      );
      AddressModel addressModel = _buildAddressModel(isUpdate);
      await repository.uploadOrUpdateAddress(
          addressModel: addressModel, isUpdate: isUpdate);
      clearInputField();
      Get.offNamed(RoutesName.billPage);
      Get.back();
      AppsFunction.flutterToast(
          msg: isUpdate
              ? "Sucessfully Update"
              : "Successfully Upload a New Address");
    } catch (e) {
      Get.back();
      if (e is AppException) {
        AppsFunction.errorDialog(
            icon: IconAsset.warningIcon,
            title: e.title!,
            content: e.message,
            buttonText: "Okay");
      }
    } finally {
      isChange.value = false;
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

  AddressModel _buildAddressModel(bool isUpdate) {
    if (!isUpdate) {
      id.value = DateTime.now().millisecondsSinceEpoch.toString();
    }
    completeAddress.value = [
      flatHouseNumberTEC.text.trim(),
      streetnameornumberTEC.text.trim(),
      villageTEC.text.trim(),
      cityTEC.text.trim(),
      countryTEC.text.trim()
    ].join(", ");
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
