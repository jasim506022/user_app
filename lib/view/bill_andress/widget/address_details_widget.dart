import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/address_controller.dart';

import '../../../res/app_colors.dart';
import '../../../res/app_function.dart';

import '../../../res/apps_text_style.dart';
import '../../../res/routes/routes_name.dart';

import 'address_list_widget.dart';

class AddressDetailsWidget extends StatelessWidget {
  const AddressDetailsWidget({super.key});

  static const int maxAddresses = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 250.h,
          child: const AddressListWidget(),
        ),
      ],
    );
  }

  Row _buildHeader() {
    return Row(
      children: [
        Text("Delivery Address",
            style: AppsTextStyle.largeBoldText
                .copyWith(color: AppColors.accentGreen)),
        const Spacer(),
        InkWell(
          onTap: () async {
            if (Get.find<AddressController>().length.value >= maxAddresses) {
              AppsFunction.flutterToast(
                  msg: "No Addressed because you Already 4 Address Added");
            } else {
              if (!(await AppsFunction.verifyInternetStatus())) {
                Get.toNamed(
                  RoutesName.addressPage,
                );
              }
            }
          },
          child: Text("+Add",
              style: AppsTextStyle.largeBoldText
                  .copyWith(color: AppColors.accentGreen)),
        )
      ],
    );
  }
}
