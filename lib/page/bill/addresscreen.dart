import 'package:flutter/material.dart';
import 'package:user_app/const/textstyle.dart';

import 'package:user_app/page/bill/billlscreen.dart';
import 'package:user_app/service/database/firebasedatabase.dart';

import '../../const/const.dart';
import '../../const/gobalcolor.dart';
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
    Textstyle textstyle = Textstyle(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          widget.isUpdate! ? "Update Address Screen" : "Add Address Screen",
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: greenColor,
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
                    validator: (p0) {},
                    controller: nameTEC,
                    hintText: 'Name',
                    textInputType: TextInputType.text,
                  ),
                  TextFieldFormWidget(
                    validator: (p0) {},
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
                                textstyle.mediumText600.copyWith(color: black),
                            underline: Container(
                              height: 2,
                              color: greenColor,
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
                                  style: textstyle.smallestText
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
