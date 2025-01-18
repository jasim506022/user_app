import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/address_controller.dart';
import '../../../res/app_colors.dart';
import '../../../res/app_constant.dart';
import '../../../res/apps_text_style.dart';

class AddressType extends StatelessWidget {
  const AddressType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var addressController = Get.find<AddressController>();
    return Obx(
      () => DropdownButton<String>(
        value: addressController.currentDropdownAddress.value,
        elevation: 16,
        underline: Container(
          height: 2,
          color: AppColors.accentGreen,
        ),
        onChanged: (String? value) {
          addressController.setDropdownAddress(value!);
          addressController.addChangeListener();
        },
        items: AppConstant.addressTypes
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: AppsTextStyle.mediumBoldText.copyWith(fontSize: 14.sp),
            ),
          );
        }).toList(),
      ),
    );
  }
}
