import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:user_app/res/routes/routesname.dart';

import '../../controller/address_controller.dart';
import '../../model/address_model.dart';
import '../../res/app_colors.dart';
import '../../res/textstyle.dart';
import '../../res/utils.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    // required this.currentIndex,
    required this.addressModel,
    required this.index,
  });

  // final int currentIndex;
  final int index;
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    // Textstyle textstyle = Textstyle(context);
    var addressController = Get.put(AddressController(
      Get.find(),
    ));
    Utils utils = Utils(context);
    return Obx(
      () => Container(
        alignment: Alignment.center,
        height: 120,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
            border: Border.all(
                color: addressController.currentAddressIndex.value == index
                    ? AppColors.greenColor
                    : Theme.of(context).cardColor,
                width: 2),
            color: utils.green50,
            borderRadius: BorderRadius.circular(25)),
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
                      const SizedBox(
                        width: 5,
                      ),
                      Text(addressModel.deliveryplace!,
                          style: Textstyle.largestText),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    addressModel.completeaddress!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12,
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => AddOrUpdateAddressScreen(
                //           isUpdate: true, addressModel: addressModel),
                //     ));
              },
              child: Icon(Typicons.edit, size: 40, color: AppColors.greenColor),
            )
          ],
        ),
      ),
    );
  }
}
