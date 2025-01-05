import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_app/res/app_string.dart';
import 'package:user_app/view/home/widget/network_utili.dart';

import '../../../controller/address_controller.dart';
import '../../../model/address_model.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';
import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';

import '../../../res/utils.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.addressModel,
    required this.index,
  });

  final int index;
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    var addressController = Get.find<AddressController>();

    return Obx(() => Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: InkWell(
            onLongPress: () async {
              if (!(await NetworkUtili.verifyInternetStatus())) {
                addressController.deleteAddress();
              }
            },
            onTap: () {
              addressController.setIndex(index);
              addressController.setAddressId(addressModel.addressId!);
            },
            child: Container(
              alignment: Alignment.center,
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
              decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          addressController.currentAddressIndex.value == index
                              ? AppColors.accentGreen
                              : Theme.of(context).cardColor,
                      width: 2),
                  color: Utils.green50,
                  borderRadius: BorderRadius.circular(25.r)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              addressController.currentAddressIndex.value ==
                                      index
                                  ? Icons.home
                                  : Icons.home_outlined,
                              size: 30,
                              color: AppColors.accentGreen,
                            ),
                            AppsFunction.horizontalSpace(5),
                            Text(addressModel.deliveryplace!,
                                style: AppsTextStyle.largestText),
                          ],
                        ),
                        AppsFunction.verticleSpace(8),
                        Text(addressModel.completeaddress!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppsTextStyle.smallestText
                                .copyWith(color: Colors.grey, fontSize: 12))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (!(await NetworkUtili.verifyInternetStatus())) {
                        Get.toNamed(RoutesName.addressPage, arguments: {
                          AppString.isUpdate: true,
                          AppString.addressModel: addressModel
                        });
                      }
                    },
                    child: Icon(Typicons.edit,
                        size: 40, color: AppColors.accentGreen),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
