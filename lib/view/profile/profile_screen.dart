import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/routes/routesname.dart';
import '../../res/app_colors.dart';
import '../../service/provider/theme_provider.dart';
import '../order/historypage.dart';
import '../order/orderpage.dart';
import 'widget/list_title_widget.dart';
import 'widget/profile_header_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings_outlined,
                size: 25,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
      body: Column(
        children: [
          const ProifleHeaderWidget(),
          Container(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              children: [
                const Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                ListTitleWidget(
                  icon: Icons.home_outlined,
                  title: 'About',
                  funcion: () {
                    Get.toNamed(RoutesName.editProfileScreen);
                  },
                ),

                //home
                ListTitleWidget(
                  icon: Icons.home_outlined,
                  title: 'Home',
                  funcion: () {
                    Get.offAndToNamed(RoutesName.mainPage, arguments: 0);
                  },
                ),

                ListTitleWidget(
                  icon: Icons.reorder,
                  title: 'My Orders',
                  funcion: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderPage(),
                        ));
                  },
                ),

                ListTitleWidget(
                  icon: Icons.access_time,
                  title: 'History',
                  funcion: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HistoryPage(),
                        ));
                  },
                ),
                ListTitleWidget(
                  icon: Icons.search,
                  title: 'Search',
                  funcion: () {},
                ),

                Consumer<ThemeProvider>(
                  builder: (context, themeProvider, child) {
                    return SwitchListTile(
                      secondary: themeProvider.getDarkTheme
                          ? Icon(
                              Icons.dark_mode,
                              color: AppColors.white,
                              size: 25,
                            )
                          : const Icon(Icons.light_mode),
                      title: Text(
                        themeProvider.getDarkTheme ? "Dark" : "Light",
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      activeColor: AppColors.white,
                      onChanged: (bool value) {
                        themeProvider.setDarkTheme = value;
                        setState(() {});
                      },
                      value: themeProvider.getDarkTheme,
                    );
                  },
                ),

                ListTitleWidget(
                  colors: AppColors.red,
                  icon: Icons.exit_to_app,
                  title: 'Sign Out',
                  funcion: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
