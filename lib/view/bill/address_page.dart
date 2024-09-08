import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/address_controller.dart';
import '../../model/address_model.dart';
import '../../res/app_function.dart';
import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../res/textstyle.dart';
import '../../widget/text_form_field_widget.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // final AddressController addressController = Get.put(AddressController());
  AddressController addressController = Get.find();

  /// Why this better final
  bool _isUpdate = false;
  late final AddressModel? _addressModel;

  @override
  void initState() {
    // addressController.isChange.value = true;
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      _isUpdate = arguments["isUpdate"] ?? false; // meaning of this ?? and ??=
      _addressModel = arguments["addressModel"];

      if (_isUpdate && _addressModel != null) {
        _updateFiled();
      }
    }

    super.initState();
  }

  // meaning of ..
  void _updateFiled() {
    addressController
      ..id.value = _addressModel!.addressId!
      ..nameTEC.text = _addressModel!.name!
      ..phoneTEC.text = _addressModel!.phone!
      ..flatHouseNumberTEC.text = _addressModel!.flatno!
      ..streetnameornumberTEC.text = _addressModel!.streetno!
      ..villageTEC.text = _addressModel!.village!
      ..cityTEC.text = _addressModel!.city!
      ..countryTEC.text = _addressModel!.country!
      ..dropdownValue.value = _addressModel!.deliveryplace!
      ..completeAdddress.value = _addressModel!.completeaddress!;
  }

  var key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        if (addressController.isChange.value == false) {
          // Get.delete<AddressController>();
          Get.back();
        }
        if (addressController.isChange.value) {
          AppsFunction.saveDialog();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            _isUpdate ? "Update Address " : "Add Address ",
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.greenColor,
            onPressed: () {
              if (!key.currentState!.validate()) return;

              addressController.uploadAndUpdateAddress(_isUpdate);

              // key.currentState!.reset();
            },
            icon: const Icon(Icons.update),
            label: Text(
              _isUpdate ? "Update" : "Save",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
            children: [
              _buildAddressForm(),
              const SizedBox(
                height: 350,
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
      key: key,
      child: Column(
        children: [
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
              print(addressController.isChange.value);
            },
            validator: (value) {
              if (value!.isEmpty) return "Please Enter You Name";
              if (value.length <= 2) {
                return "Name Must be longer than 2 Characters";
              }

              return null;
            },
            controller: addressController.nameTEC,
            hintText: 'Name',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter You Phone Number";
              } else if (value.length != 11) {
                return "Phone Number Must be Exactly 11 Digit";
              }
              return null;
            },
            controller: addressController.phoneTEC,
            hintText: 'Phone',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
              // print(addressController.isChange.value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your flat/house number.";
              }
            },
            controller: addressController.flatHouseNumberTEC,
            hintText: 'Flat/House Number',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your Street number Or Name.";
              }
            },
            controller: addressController.streetnameornumberTEC,
            hintText: 'Street Number or name',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your Village Name.";
              }
            },
            controller: addressController.villageTEC,
            hintText: 'Village Name',
            textInputType: TextInputType.text,
          ),
          TextFormFieldWidget(
            onChanged: (p0) {
              addressController.addChangeListener();
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter your City Name.";
              }
            },
            controller: addressController.cityTEC,
            hintText: 'City Name',
            textInputType: TextInputType.text,
          ),
          Row(
            children: [
              Flexible(
                flex: 5,
                child: TextFormFieldWidget(
                  onChanged: (p0) {
                    addressController.addChangeListener();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your Country Name.";
                    }
                  },
                  controller: addressController.countryTEC,
                  hintText: 'Country Name',
                  textInputType: TextInputType.text,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                  flex: 2,
                  child: Obx(
                    () => DropdownButton<String>(
                      value: addressController.dropdownValue.value,
                      elevation: 16,
                      style: Textstyle.mediumText600
                          .copyWith(color: AppColors.black),
                      underline: Container(
                        height: 2,
                        color: AppColors.greenColor,
                      ),
                      onChanged: (String? value) {
                        addressController.changeAddress(value!);
                        addressController.markAsChange();
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style:
                                Textstyle.smallestText.copyWith(fontSize: 14),
                          ),
                        );
                      }).toList(),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}









/// New Address
/*

class AddOrUpdateAddressScreen extends StatefulWidget {
  AddOrUpdateAddressScreen(
      {super.key, this.isUpdate = false, this.addressModel});

  bool? isUpdate;
  AddressModel? addressModel;

  @override
  State<AddOrUpdateAddressScreen> createState() =>
      _AddOrUpdateAddressScreenState();
}

class _AddOrUpdateAddressScreenState extends State<AddOrUpdateAddressScreen> {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController flatHouseNumberTEC = TextEditingController();
  TextEditingController streetnameornumberTEC = TextEditingController();
  TextEditingController villageTEC = TextEditingController();
  TextEditingController cityTEC = TextEditingController();
  TextEditingController countryTEC = TextEditingController();

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    if (widget.isUpdate!) {
      id = widget.addressModel!.addressId!;
      nameTEC.text = widget.addressModel!.name!;
      phoneTEC.text = widget.addressModel!.phone!;
      flatHouseNumberTEC.text = widget.addressModel!.flatno!;
      streetnameornumberTEC.text = widget.addressModel!.streetno!;
      villageTEC.text = widget.addressModel!.village!;
      cityTEC.text = widget.addressModel!.city!;
      countryTEC.text = widget.addressModel!.country!;
      dropdownValue = widget.addressModel!.deliveryplace!;
      completeAdddress = widget.addressModel!.completeaddress!;
    }
    super.initState();
  }

  var key = GlobalKey<FormState>();

  String dropdownValue = list.first;
  String completeAdddress = "";

  @override
  Widget build(BuildContext context) {
    // Textstyle textstyle = Textstyle(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.isUpdate! ? "Update Address Screen" : "Add Address Screen",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.greenColor,
          onPressed: () {
            if (key.currentState!.validate()) {
              if (widget.isUpdate!) {
                completeAdddress =
                    "${flatHouseNumberTEC.text.trim()}, ${streetnameornumberTEC.text.trim()}, ${villageTEC.text.trim()}, ${cityTEC.text.trim()}, ${countryTEC.text.trim()}";
                FirebaseDatabase.allorUpdateAddressSnapshot(id: id).update({
                  "name": nameTEC.text.trim(),
                  "phone": phoneTEC.text.trim(),
                  "flatno": flatHouseNumberTEC.text.trim(),
                  "streetno": streetnameornumberTEC.text.trim(),
                  "village": villageTEC.text.trim(),
                  "city": cityTEC.text.trim(),
                  "country": countryTEC.text.trim(),
                  "deliveryplace": dropdownValue,
                  "completeaddress": completeAdddress
                }).then((value) {
                  AppsFunction.flutterToast(msg: "Address Save Succefully");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BillPage(),
                      ));
                  key.currentState!.reset();
                }).onError((error, stackTrace) {
                  AppsFunction.flutterToast(msg: error.toString());
                });
              } else {
                completeAdddress =
                    "${flatHouseNumberTEC.text.trim()}, ${streetnameornumberTEC.text.trim()}, ${villageTEC.text.trim()}, ${cityTEC.text.trim()}, ${countryTEC.text.trim()}";
                FirebaseDatabase.allorUpdateAddressSnapshot(id: id).set({
                  "id": id,
                  "name": nameTEC.text.trim(),
                  "phone": phoneTEC.text.trim(),
                  "flatno": flatHouseNumberTEC.text.trim(),
                  "streetno": streetnameornumberTEC.text.trim(),
                  "village": villageTEC.text.trim(),
                  "city": cityTEC.text.trim(),
                  "country": countryTEC.text.trim(),
                  "deliveryplace": dropdownValue,
                  "completeaddress": completeAdddress
                }).then((value) {
                  AppsFunction.flutterToast(msg: "Address Save Succefully");
                 
                  key.currentState!.reset();
                }).onError((error, stackTrace) {
                  AppsFunction.flutterToast(msg: error.toString());
                });
              }
            }
          },
          icon: const Icon(Icons.save),
          label: Text(
            widget.isUpdate! ? "Update" : "Save",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  TextFormFieldWidget(
                    validator: (p0) {
                      return null;
                    },
                    controller: nameTEC,
                    hintText: 'Name',
                    textInputType: TextInputType.text,
                  ),
                  TextFormFieldWidget(
                    validator: (p0) {
                      return null;
                    },
                    controller: phoneTEC,
                    hintText: 'Phone',
                    textInputType: TextInputType.phone,
                  ),
                  TextFormFieldWidget(
                    controller: flatHouseNumberTEC,
                    hintText: 'Flat/House Number',
                    textInputType: TextInputType.text,
                  ),
                  TextFormFieldWidget(
                    controller: streetnameornumberTEC,
                    hintText: 'Street Number or name',
                    textInputType: TextInputType.text,
                  ),
                  TextFormFieldWidget(
                    controller: villageTEC,
                    hintText: 'Village Name',
                    textInputType: TextInputType.text,
                  ),
                  TextFormFieldWidget(
                    controller: cityTEC,
                    hintText: 'City Name',
                    textInputType: TextInputType.text,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TextFormFieldWidget(
                          controller: countryTEC,
                          hintText: 'Country Name',
                          textInputType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                          flex: 2,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            elevation: 16,
                            style: Textstyle.mediumText600
                                .copyWith(color: AppColors.black),
                            underline: Container(
                              height: 2,
                              color: AppColors.greenColor,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Textstyle.smallestText
                                      .copyWith(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 350,
            )
          ],
        ),
      ),
    );
  }
}



























*/

/*
import 'package:flutter/material.dart';
import 'package:user_app/res/textstyle.dart';

import 'package:user_app/view/bill/billlscreen.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

import '../../res/constants.dart';
import '../../res/app_colors.dart';
import '../../model/addressmodel.dart';
import '../../widget/textfieldformwidget.dart';

// ignore: must_be_immutable
class AddOrUpdateAddressScreen extends StatefulWidget {
  AddOrUpdateAddressScreen(
      {super.key, this.isUpdate = false, this.addressModel});

  bool? isUpdate;
  AddressModel? addressModel;

  @override
  State<AddOrUpdateAddressScreen> createState() =>
      _AddOrUpdateAddressScreenState();
}

class _AddOrUpdateAddressScreenState extends State<AddOrUpdateAddressScreen> {
  TextEditingController nameTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();
  TextEditingController flatHouseNumberTEC = TextEditingController();
  TextEditingController streetnameornumberTEC = TextEditingController();
  TextEditingController villageTEC = TextEditingController();
  TextEditingController cityTEC = TextEditingController();
  TextEditingController countryTEC = TextEditingController();

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    if (widget.isUpdate!) {
      id = widget.addressModel!.addressId!;
      nameTEC.text = widget.addressModel!.name!;
      phoneTEC.text = widget.addressModel!.phone!;
      flatHouseNumberTEC.text = widget.addressModel!.flatno!;
      streetnameornumberTEC.text = widget.addressModel!.streetno!;
      villageTEC.text = widget.addressModel!.village!;
      cityTEC.text = widget.addressModel!.city!;
      countryTEC.text = widget.addressModel!.country!;
      dropdownValue = widget.addressModel!.deliveryplace!;
      completeAdddress = widget.addressModel!.completeaddress!;
    }
    super.initState();
  }

  var key = GlobalKey<FormState>();

  String dropdownValue = list.first;
  String completeAdddress = "";

  @override
  Widget build(BuildContext context) {
    // Textstyle textstyle = Textstyle(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.isUpdate! ? "Update Address Screen" : "Add Address Screen",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor:AppColors. greenColor,
          onPressed: () {
            if (key.currentState!.validate()) {
              if (widget.isUpdate!) {
                completeAdddress =
                    "${flatHouseNumberTEC.text.trim()}, ${streetnameornumberTEC.text.trim()}, ${villageTEC.text.trim()}, ${cityTEC.text.trim()}, ${countryTEC.text.trim()}";
                FirebaseDatabase.allorUpdateAddressSnapshot(id: id).update({
                  "name": nameTEC.text.trim(),
                  "phone": phoneTEC.text.trim(),
                  "flatno": flatHouseNumberTEC.text.trim(),
                  "streetno": streetnameornumberTEC.text.trim(),
                  "village": villageTEC.text.trim(),
                  "city": cityTEC.text.trim(),
                  "country": countryTEC.text.trim(),
                  "deliveryplace": dropdownValue,
                  "completeaddress": completeAdddress
                }).then((value) {
                  globalMethod.flutterToast(msg: "Address Save Succefully");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BillPage(),
                      ));
                  key.currentState!.reset();
                }).onError((error, stackTrace) {
                  globalMethod.flutterToast(msg: error.toString());
                });
              } else {
                completeAdddress =
                    "${flatHouseNumberTEC.text.trim()}, ${streetnameornumberTEC.text.trim()}, ${villageTEC.text.trim()}, ${cityTEC.text.trim()}, ${countryTEC.text.trim()}";
                FirebaseDatabase.allorUpdateAddressSnapshot(id: id).set({
                  "id": id,
                  "name": nameTEC.text.trim(),
                  "phone": phoneTEC.text.trim(),
                  "flatno": flatHouseNumberTEC.text.trim(),
                  "streetno": streetnameornumberTEC.text.trim(),
                  "village": villageTEC.text.trim(),
                  "city": cityTEC.text.trim(),
                  "country": countryTEC.text.trim(),
                  "deliveryplace": dropdownValue,
                  "completeaddress": completeAdddress
                }).then((value) {
                  globalMethod.flutterToast(msg: "Address Save Succefully");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BillPage(),
                      ));
                  key.currentState!.reset();
                }).onError((error, stackTrace) {
                  globalMethod.flutterToast(msg: error.toString());
                });
              }
            }
          },
          icon: const Icon(Icons.save),
          label: Text(
            widget.isUpdate! ? "Update" : "Save",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  TextFieldFormWidget(
                    validator: (p0) {
                      return null;
                    },
                    controller: nameTEC,
                    hintText: 'Name',
                    textInputType: TextInputType.text,
                  ),
                  TextFieldFormWidget(
                    validator: (p0) {
                      return null;
                    },
                    controller: phoneTEC,
                    hintText: 'Phone',
                    textInputType: TextInputType.phone,
                  ),
                  TextFieldFormWidget(
                    controller: flatHouseNumberTEC,
                    hintText: 'Flat/House Number',
                    textInputType: TextInputType.text,
                  ),
                  TextFieldFormWidget(
                    controller: streetnameornumberTEC,
                    hintText: 'Street Number or name',
                    textInputType: TextInputType.text,
                  ),
                  TextFieldFormWidget(
                    controller: villageTEC,
                    hintText: 'Village Name',
                    textInputType: TextInputType.text,
                  ),
                  TextFieldFormWidget(
                    controller: cityTEC,
                    hintText: 'City Name',
                    textInputType: TextInputType.text,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TextFieldFormWidget(
                          controller: countryTEC,
                          hintText: 'Country Name',
                          textInputType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Flexible(
                          flex: 2,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            elevation: 16,
                            style:
                                Textstyle.mediumText600.copyWith(color:AppColors. black),
                            underline: Container(
                              height: 2,
                              color: AppColors.greenColor,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: list
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: Textstyle.smallestText
                                      .copyWith(fontSize: 14),
                                ),
                              );
                            }).toList(),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 350,
            )
          ],
        ),
      ),
    );
  }
}
*/
