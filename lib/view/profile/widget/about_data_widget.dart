
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/profile_controller.dart';
import 'about_data_item.dart';

class AboutDataWidget extends StatelessWidget {
  const AboutDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    return Obx(() {
      var profileModel = profileController.profileModel.value;

      // Show loading indicator if any of the fields are null
      if ([
        profileModel.name,
        profileModel.phone,
        profileModel.email,
        profileModel.address
      ].contains(null)) {
        return const CircularProgressIndicator();
      }

      // Profile data to be displayed
      final profileData = [
        {
          'icon': Icons.person,
          'label': "Name",
          'value': profileModel.name,
        },
        {
          'icon': Icons.phone,
          'label': "Phone",
          'value': "0${profileModel.phone}",
        },
        {
          'icon': Icons.email,
          'label': "Email",
          'value': profileModel.email,
        },
        {
          'icon': Icons.place,
          'label': "Address",
          'value': profileModel.address,
        },
      ];

      return Column(
        children: profileData
            .map((item) => AboutDataItem(
                  item: item,
                ))
            .toList(),
      );
    });
  }
}

