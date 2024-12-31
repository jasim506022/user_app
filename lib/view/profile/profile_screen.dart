import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_string.dart';

import '../../controller/profile_controller.dart';
import '../../res/app_colors.dart';
import '../../res/app_function.dart';
import '../../res/apps_text_style.dart';
import '../../res/routes/routes_name.dart';
import '../../service/provider/theme_provider.dart';
import '../../widget/show_alert_dialog_widget.dart';
import 'widget/custom_list_tile.dart';
import 'widget/profile_header_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.profile),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                size: 25.h,
              ))
        ],
      ),
      body: Column(
        children: [
          const ProifleHeaderWidget(),
          Expanded(
            child: ListView(
              children: [
                Divider(
                  height: 10.h,
                  color: Theme.of(context).hintColor,
                  thickness: 2,
                ),
                _buildProfileMenuItems(context),
                _buildThemeSwitch(context),
                _buildSignOutTile()
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dynamically build list of profile menu items
  Widget _buildProfileMenuItems(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "icon": Icons.info_outline,
        "title": AppString.about,
        "route": RoutesName.editProfileScreen
      },
      {
        "icon": Icons.home_outlined,
        "title": AppString.home,
        "route": RoutesName.mainPage,
        "argument": 0
      },
      {
        "icon": Icons.reorder,
        "title": AppString.myOrder,
        "route": RoutesName.orderPage
      },
      {
        "icon": Icons.access_time,
        "title": AppString.history,
        "route": RoutesName.historyPage
      },
      {
        "icon": Icons.search,
        "title": AppString.search,
        "route": RoutesName.mainPage,
        "argument": 2
      },
    ];

    return Column(
      children: menuItems.map((item) {
        return CustomListTile(
          icon: item['icon'],
          title: item['title'],
          onTap: () async {
            if (!(await AppsFunction.verifyInternetStatus())) {
              if (item['argument'] is int) {
                Get.offAndToNamed(item['route'], arguments: item['argument']);
              } else {
                Get.toNamed(item['route']);
              }
            }
          },
        );
      }).toList(),
    );
  }

  // Build theme switcher widget
  Widget _buildThemeSwitch(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SwitchListTile(
          secondary: Icon(
            themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
            color: themeProvider.getDarkTheme
                ? AppColors.white
                : Theme.of(context).primaryColor,
            size: 25.h,
          ),
          title: Text(
            themeProvider.getDarkTheme ? AppString.dark : AppString.light,
            style: AppsTextStyle.largeBoldText,
          ),
          activeColor: AppColors.white,
          onChanged: (bool value) {
            themeProvider.setDarkTheme = value;
          },
          value: themeProvider.getDarkTheme,
        );
      },
    );
  }

  Widget _buildSignOutTile() {
    return CustomListTile(
      icon: Icons.exit_to_app,
      title: AppString.signOut,
      iconColor: AppColors.red,
      onTap: () async {
        if (!(await AppsFunction.verifyInternetStatus())) {
          Get.dialog(CustomAlertDialogWidget(
            icon: Icons.delete,
            title: AppString.signOut,
            subTitle: AppString.doYouWantSignount,
            yesOnPress: () async => await profileController.signOut(),
          ));
        }
      },
    );
  }
}
