import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/address_controller.dart';
import '../../../loading_widget/loading_addres_swidget.dart';
import '../../../model/address_model.dart';

import '../../../res/app_asset/app_imges.dart';
import '../../../res/app_string.dart';
import '../../../widget/single_empty_widget.dart';
import 'address_widget.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = Get.find<AddressController>();
    if (kDebugMode) {
      print(addressController.addressid.value);
    }
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
            image: AppImages.errorSingle,
            title: snapshot.hasError
                ? '${AppString.errorOccure} ${snapshot.error}'
                : AppString.noAddressAvaiblabe,
          );
        }

        if (snapshot.hasData) {
          final addressList = snapshot.data!.docs;
          addressController.length.value = addressList.length;

          // Set initial addressId if not already set
          if (addressController.addressid.value.isEmpty &&
              addressList.isNotEmpty) {
            final firstAddressModel =
                AddressModel.fromMap(addressList.first.data());
            addressController.setAddressId(firstAddressModel.addressId!);
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              AddressModel addressModel =
                  AddressModel.fromMap(snapshot.data!.docs[index].data());

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
