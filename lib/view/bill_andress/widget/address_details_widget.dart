import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/address_controller.dart';
import '../../../model/address_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/appasset/image_asset.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';

import '../../../widget/single_empty_widget.dart';
import 'address_widget.dart';
import 'loading_addres_swidget.dart';

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var addressController = Get.find<AddressController>();
    return Column(
      children: [
        _buildHeader(addressController),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 200.h,
          child: _buildAddressListBuilder(addressController),
        ),
      ],
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _buildAddressListBuilder(
      AddressController addressController) {
    return StreamBuilder(
      stream: addressController.addressSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingList();
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
              if (addressController.addressid.value == "") {
                addressController.setAddressId(addressModel.addressId!);
              }
              return Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: InkWell(
                  onLongPress: () {
                    AppsFunction.confirmationDialog(
                      title: "Confirm Deletion?",
                      subTitle:
                          'Are you sure you want to delete this item? This action cannot be undone.',
                      yesFunction: () {
                        addressController.deleteAddress(
                            addressId: addressModel.addressId!);
                        Get.back();
                      },
                    );
                  },
                  onTap: () {
                    addressController.setIndex(index);
                    addressController.setAddressId(addressModel.addressId!);
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
        return _buildLoadingList();
      },
    );
  }

  /// Builds a loading state with placeholder widgets
  Widget _buildLoadingList() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const LoadingAddressWidget();
      },
    );
  }

  Row _buildHeader(AddressController addressController) {
    return Row(
      children: [
        Text("Delivery Address",
            style: AppsTextStyle.largeBoldText
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
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: AppColors.greenColor)),
        )
      ],
    );
  }
}
