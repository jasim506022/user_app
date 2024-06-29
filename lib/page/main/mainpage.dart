import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../res/constants.dart';
import '../../res/gobalcolor.dart';
import '../home/homepage.dart';
import '../order/orderpage.dart';
import '../profile/profilescreen.dart';
import '../search/searchpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> widgetOptions = [
    const HomePage(),
    const OrderPage(),
    const SearchPage(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    globalMethod.getUserInformation();
  }

  int currentIndex = 0;
  int? indexValue;

  @override
  void didChangeDependencies() {
    final dynamic data = ModalRoute.of(context)!.settings.arguments;
    indexValue = data;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Theme.of(context).cardColor,
          currentIndex: indexValue ?? currentIndex,
          onTap: (i) => setState(() {
            currentIndex = i;
            indexValue = null;
          }),
          items: [
            SalomonBottomBarItem(
                activeIcon: Icon(
                  Icons.home,
                  color: greenColor,
                ),
                icon: const Icon(Icons.home_outlined),
                title: const Text(
                  "Home",
                ),
                selectedColor: greenColor,
                unselectedColor: Theme.of(context).indicatorColor),
            SalomonBottomBarItem(
                activeIcon: Icon(
                  Icons.favorite_border,
                  color: greenColor,
                ),
                icon: const Icon(Icons.favorite_border_outlined),
                title: const Text("Likes"),
                unselectedColor: Theme.of(context).indicatorColor,
                selectedColor: greenColor),
            SalomonBottomBarItem(
                activeIcon: Icon(
                  Icons.search,
                  color: greenColor,
                ),
                icon: const Icon(Icons.search_outlined),
                title: const Text("Search"),
                unselectedColor: Theme.of(context).indicatorColor,
                selectedColor: greenColor),
            SalomonBottomBarItem(
                activeIcon: Icon(
                  Icons.person,
                  color: greenColor,
                ),
                icon: const Icon(Icons.person_outline),
                unselectedColor: Theme.of(context).indicatorColor,
                title: const Text("Profile"),
                selectedColor: greenColor),
          ],
        ),
        body: widgetOptions[indexValue ?? currentIndex]);
  }
}
