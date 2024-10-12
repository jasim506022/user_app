import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controller/address_controller.dart';
import '../../../model/address_model.dart';
import '../../../res/app_colors.dart';
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
    var addressController = Get.put(AddressController(
      Get.find(),
    ));
    Utils utils = Utils(context);
    return Obx(
      () => Container(
        alignment: Alignment.center,
        height: 85.h,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.h),
        decoration: BoxDecoration(
            border: Border.all(
                color: addressController.currentAddressIndex.value == index
                    ? AppColors.greenColor
                    : Theme.of(context).cardColor,
                width: 2),
            color: utils.green50,
            borderRadius: BorderRadius.circular(25.r)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      addressController.currentAddressIndex.value == index
                          ? Icon(
                              Icons.home,
                              size: 30,
                              color: AppColors.greenColor,
                            )
                          : const Icon(
                              Icons.home_outlined,
                              size: 30,
                            ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(addressModel.deliveryplace!,
                          style: AppsTextStyle.largestText),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    addressModel.completeaddress!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(RoutesName.addressPage, arguments: {
                  "isUpdate": true,
                  "addressModel": addressModel
                });
              },
              child: Icon(Typicons.edit, size: 40, color: AppColors.greenColor),
            )
          ],
        ),
      ),
    );
  }
}
