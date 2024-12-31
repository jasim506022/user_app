import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/address_controller.dart';
import '../../../loading_widget/loading_addres_swidget.dart';
import '../../../model/address_model.dart';

import '../../../res/app_asset/image_asset.dart';
import '../../../widget/single_empty_widget.dart';
import 'address_widget.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = Get.find<AddressController>();
    return StreamBuilder(
      stream: addressController.addressSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingAddressWidget();
        }

        if (!snapshot.hasData ||
            snapshot.data!.docs.isEmpty ||
            snapshot.hasError) {
          return SingleEmptyWidget(
            image: ImagesAsset.errorSingle,
            title: snapshot.hasError
                ? 'Error Occure: ${snapshot.error}'
                : 'No Address Available',
          );
        }

        if (snapshot.hasData) {
          addressController.length.value = snapshot.data!.docs.length;
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              AddressModel addressModel =
                  AddressModel.fromMap(snapshot.data!.docs[index].data());
              if (addressController.addressid.value == "") {
                addressController.setAddressId(addressModel.addressId!);
              }
              return AddressWidget(
                addressModel: addressModel,
                index: index,
              );
            },
          );
        }
        return const LoadingAddressWidget();
      },
    );
  }
}
