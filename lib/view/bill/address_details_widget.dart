
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_app/model/address_model.dart';
import 'package:user_app/res/app_colors.dart';
import 'package:user_app/res/app_function.dart';
import 'package:user_app/res/routes/routesname.dart';
import 'package:user_app/res/textstyle.dart';
import 'package:user_app/view/bill/addresswidget.dart';
import 'package:user_app/view/bill/loadingaddresswidget.dart';

import '../../controller/address_controller.dart';

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = Get.put(AddressController(
      Get.find(),
    ));
    return Column(
      children: [
        Row(
          children: [
            Text("Delivery Address",
                style: Textstyle.largeBoldText
                    .copyWith(color: AppColors.greenColor)),
            const Spacer(),
            InkWell(
              onTap: () {
                if (addressController.length.value >= 4) {
                  AppsFunction.flutterToast(
                      msg: "No Addressed because you Already 4 Address Added");
                } else {
                  Get.toNamed(
                    RoutesName.addressPage,
                  );
                }
              },
              child: Text("+Add",
                  style: Textstyle.largeBoldText
                      .copyWith(color: AppColors.greenColor)),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 280,
          child: StreamBuilder(
            stream: addressController.addressSnapshot(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const LoadingAddressWidget();
                  },
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No Address Available"));
              }

              if (snapshot.hasError) {
                return const Text("Error");
              }
              if (snapshot.hasData) {
                addressController.length.value = snapshot.data!.docs.length;
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    AddressModel addressModel =
                        AddressModel.fromMap(snapshot.data!.docs[index].data());
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onLongPress: () {
                          AppsFunction.deleteDialog(
                            function: () {
                              addressController.deleteAddress(
                                  addressId: addressModel.addressId!);
                              Get.back();
                            },
                          );
                        },
                        onTap: () {
                          addressController.setIndex(index);
                          addressController
                              .setAddressId(addressModel.addressId!);
                        },
                        child: AddressWidget(
                          addressModel: addressModel,
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              }
              return Text("Okay");
            },
          ),
        ),
      ],
    );
  }
}

