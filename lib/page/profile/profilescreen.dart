import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../auth/signinpage.dart';
import '../../res/constants.dart';
import '../../res/gobalcolor.dart';
import '../../res/textstyle.dart';
import '../../service/provider/theme_provider.dart';
import '../main/mainpage.dart';
import '../order/historypage.dart';
import '../order/orderpage.dart';
import 'editprofilescrren.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Textstyle textstyle = Textstyle(context);
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
          Container(
              height: MediaQuery.of(context).size.height * .18,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .52,
                      width: MediaQuery.of(context).size.height * .15,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            sharedPreference!.getString("imageurl")!),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(sharedPreference!.getString("name")!,
                                style: textstyle.largeText.copyWith(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor)),
                            Text(sharedPreference!.getString("email")!,
                                style: textstyle.mediumText600.copyWith(
                                    fontSize: 15,
                                    color: Theme.of(context).hintColor)),
                            const SizedBox(
                              height: 8,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          greenColor),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 12)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProfileScreen(
                                                isEdit: true),
                                      ));
                                },
                                child: Text(
                                  "Edit Profile",
                                  style: GoogleFonts.poppins(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const EditProfileScreen(isEdit: false),
                        ));
                  },
                ),

                //home
                ListTitleWidget(
                  icon: Icons.home_outlined,
                  title: 'Home',
                  funcion: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ));
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
                              color: white,
                              size: 25,
                            )
                          : const Icon(Icons.light_mode),
                      title: Text(
                        themeProvider.getDarkTheme ? "Dark" : "Light",
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      activeColor: white,
                      onChanged: (bool value) {
                        themeProvider.setDarkTheme = value;
                        setState(() {});
                      },
                      value: themeProvider.getDarkTheme,
                      /* 
                    icon: Icons.search,
                    title: 'Search',
                    funcion: () {},
                  */
                    );
                  },
                ),

                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: red,
                    size: 25,
                  ),
                  title: Text(
                    "Sign Out",
                    style: GoogleFonts.poppins(
                      color: red,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => const SignInPage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ListTitleWidget extends StatelessWidget {
  const ListTitleWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.funcion,
  });

  final String title;
  final IconData icon;
  final VoidCallback funcion;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
        size: 25,
      ),
      trailing: IconButton(
          onPressed: funcion,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
            size: 20,
          )),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: Theme.of(context).primaryColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
