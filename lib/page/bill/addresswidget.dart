import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import '../../res/gobalcolor.dart';
import '../../res/textstyle.dart';
import '../../res/utils.dart';
import '../../model/addressmodel.dart';
import 'addresscreen.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    super.key,
    required this.currentIndex,
    required this.addressModel,
    required this.index,
  });

  final int currentIndex;
  final int index;
  final AddressModel addressModel;

  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
    Utils utils = Utils(context);
    return Container(
      alignment: Alignment.center,
      height: 120,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      decoration: BoxDecoration(
          border: Border.all(
              color: currentIndex == index
                  ? greenColor
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
                    currentIndex == index
                        ? Icon(
                            Icons.home,
                            size: 30,
                            color: greenColor,
                          )
                        : const Icon(
                            Icons.home_outlined,
                            size: 30,
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(addressModel.deliveryplace!,
                        style: textstyle.largestText),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrUpdateAddressScreen(
                        isUpdate: true, addressModel: addressModel),
                  ));
            },
            child: Icon(Typicons.edit, size: 40, color: greenColor),
          )
        ],
      ),
    );
  }
}
