import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../controller/network_controller.dart';
import '../../controller/profile_controller.dart';
import '../../res/app_colors.dart';
import '../../res/app_string.dart';
import '../home/home_page.dart';
import '../product/product_page.dart';
import '../profile/profile_screen.dart';
import '../search/search_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final profileController = Get.find<ProfileController>();
  int currentIndex = 0;

  late List<Widget> widgetOptions = [
    const HomePage(),
    const ProductPage(),
    const SearchPage(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    profileController.getUserInformationSnapshot();
    _initializeIndex();
  }

  @override
  void didChangeDependencies() {
    _setStatusBarStle();
    super.didChangeDependencies();
  }

  void _initializeIndex() {
    int? data = Get.arguments;
    if (data != null) {
      setState(() {
        currentIndex = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DependencyInjection.init();

    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Theme.of(context).cardColor,
          currentIndex: currentIndex,
          onTap: (i) => setState(() {
            currentIndex = i;
          }),
          items: [
            _buildBottomBarItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                title: AppString.home),
            _buildBottomBarItem(
                icon: Icons.list_outlined,
                activeIcon: Icons.list,
                title: AppString.products),
            _buildBottomBarItem(
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                title: AppString.search),
            _buildBottomBarItem(
                activeIcon: Icons.person,
                icon: Icons.person_outline,
                title: AppString.profile),
          ],
        ),
        body: widgetOptions[currentIndex]);
  }

  void _setStatusBarStle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Theme.of(context).brightness));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  SalomonBottomBarItem _buildBottomBarItem(
      {required IconData icon,
      required IconData activeIcon,
      required String title}) {
    return SalomonBottomBarItem(
        activeIcon: Icon(
          activeIcon,
          color: AppColors.accentGreen,
        ),
        icon: Icon(icon),
        unselectedColor: Theme.of(context).unselectedWidgetColor,
        title: Text(title),
        selectedColor: AppColors.accentGreen);
  }
}
