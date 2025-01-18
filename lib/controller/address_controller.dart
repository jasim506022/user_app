import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/res/app_constant.dart';
import 'package:user_app/res/app_string.dart';
import 'package:user_app/widget/loading_widget.dart';

import '../model/address_model.dart';
import '../model/app_exception.dart';
import '../repository/address_repository.dart';
import '../res/app_function.dart';
import '../res/app_asset/app_icons.dart';
import '../res/routes/routes_name.dart';
import '../widget/error_dialog_widget.dart';
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

  var currentDropdownAddress = AppConstant.addressTypes.first.obs;
  var completeAddress = "".obs;
  var addressid = "".obs;
  var currentAddressIndex = 0.obs;
  var length = 0.obs;
  var id = "".obs;
  var isChange = false.obs;

  AddressController(this.repository);

  @override
  void onInit() {
    super.onInit();
    addChangeListener();
  }

  @override
  void onClose() {
    // nameTEC.dispose();
    // phoneTEC.dispose();
    // flatHouseNumberTEC.dispose();
    // streetnameornumberTEC.dispose();
    // villageTEC.dispose();
    // cityTEC.dispose();
    // countryTEC.dispose();
    for (var controller in [
      nameTEC,
      phoneTEC,
      flatHouseNumberTEC,
      streetnameornumberTEC,
      villageTEC,
      cityTEC,
      countryTEC
    ]) {
      controller.dispose();
    }
    super.onClose();
  }

  void clearInputField() {
    nameTEC.clear();
    phoneTEC.clear();
    flatHouseNumberTEC.clear();
    streetnameornumberTEC.clear();
    villageTEC.clear();
    cityTEC.clear();
    countryTEC.clear();
    currentDropdownAddress.value = AppConstant.addressTypes[0];
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

  void handleBackNavigaion(bool didPop) {
    if (didPop) return;

    if (!isChange.value) {
      Get.back();
      return;
    }

    Get.dialog(CustomAlertDialogWidget(
      icon: Icons.question_mark_rounded,
      title: AppString.saveChaned,
      subTitle: AppString.doYouWantSave,
      yesOnPress: () => Get.back(),
      noOnPress: () {
        clearInputField();
        isChange.value = false;
        Get.close(2);
      },
    ));
  }

  void setIndex(int index) {
    currentAddressIndex.value = index;
  }

  void setAddressId(String address) {
    addressid.value = address;
  }

  void setDropdownAddress(String location) {
    currentDropdownAddress.value = location;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> addressSnapshot() {
    try {
      return repository.addressSnapshot();
    } catch (e) {
      handleException(e);
      rethrow;
    }
  }

  Future<void> deleteAddress() async {
    final confirmed = await Get.dialog<bool>(
      CustomAlertDialogWidget(
        icon: Icons.question_mark_rounded,
        title: AppString.confirmDeletion,
        subTitle: AppString.deleteMessage,
        yesOnPress: () => Get.back(result: true),
        noOnPress: () => Get.back(result: false),
      ),
    );

    if (confirmed == true) {
      try {
        await repository.deleteAddress(addressId: addressid.value);
        addressid.value = "";
        AppsFunction.showToast(msg: AppString.succwssulyDelete);
      } catch (e) {
        handleException(e);
      }
    }
  }

  // Save Address
  Future<void> saveAddress(bool isUpdate) async {
    try {
      LoadingWidget(
        message:
            isUpdate ? AppString.updateAddress : AppString.uploadNewAddress,
      );

      AddressModel addressModel = _buildAddressModel(isUpdate);
      await repository.uploadOrUpdateAddress(
          addressModel: addressModel, isUpdate: isUpdate);
      clearInputField();
      Get.back();
      Get.offNamed(AppRoutesName.billPage);

      AppsFunction.showToast(
          msg: isUpdate
              ? AppString.successfullyUpdate
              : AppString.succesffulyUploadNewAddress);
    } catch (e) {
      Get.back();
      handleException(e);
    } finally {
      isChange.value = false;
    }
  }

  void updateFields(AddressModel addressModel) {
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

  void handleException(Object e) {
    if (e is AppException) {
      // AppsFunction.errorDialog(
      //   icon: AppIcons.warningIcon,
      //   title: e.title!,
      //   content: e.message,
      //   buttonText: AppString.okay,
      // );
      Get.dialog(
        ErrorDialogWidget(
          icon: AppIcons.warningIcon,
          title: "e.title!",
          content: e.message,
          buttonText: AppString.okay,
        ),
      );
    }
  }
}
