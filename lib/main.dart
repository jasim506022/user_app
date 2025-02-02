import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bindings/initial_binding.dart';
import 'res/app_colors.dart';
import 'res/app_constant.dart';
import 'res/app_string.dart';
import 'res/routes/app_routes.dart';
import 'res/routes/routes_name.dart';
import 'service/provider/theme_provider.dart';

void main() async {
  // Initialize the Stripe payment system with the publishable key.
  Stripe.publishableKey = AppConstant.publishKey;

  // Ensure the widgets are bound to the platform and Firebase is initialized.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // Initialize SharedPreferences and retrieve the onboarding view status.
  AppConstant.sharedPreference = await SharedPreferences.getInstance();
  AppConstant.isViewed =
      AppConstant.sharedPreference!.getInt(AppString.onBoardingSharedPre);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 851),
      builder: (_, child) {
        return MultiProvider(
          providers: providerAllList,
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvder, child) {
              return GetMaterialApp(
                initialBinding: InitialBinding(),
                debugShowCheckedModeBanner: false,
                theme: _buildThemeData(themeProvder),
                initialRoute: AppRoutesName.splashScreen,
                getPages: AppRoutes.appRoutes(),
              );
            },
          ),
        );
      },
    );
  }

  /// Builds the theme data based on the selected theme (dark or light).
  ThemeData _buildThemeData(ThemeProvider themeProvder) {
    return ThemeData(

        // Dialog theme customization
        dialogTheme: DialogTheme(
            backgroundColor: themeProvder.getDarkTheme
                ? AppColors.darkCardBackground
                : AppColors.white,
            titleTextStyle: GoogleFonts.poppins(
                color: themeProvder.getDarkTheme
                    ? AppColors.white
                    : AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold),
            contentTextStyle: GoogleFonts.poppins(
                color: AppColors.black.withOpacity(.7),
                fontSize: 16.sp,
                fontWeight: FontWeight.normal)),

        // Check
        dialogBackgroundColor: themeProvder.getDarkTheme
            ? AppColors.darkBackground
            : AppColors.lightBackground,

        // AppBar theme customization

        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
              color: themeProvder.getDarkTheme
                  ? AppColors.white
                  : AppColors.black),
          backgroundColor: themeProvder.getDarkTheme
              ? AppColors.darkBackground
              : AppColors.lightBackground,
          titleTextStyle: GoogleFonts.roboto(
              color:
                  themeProvder.getDarkTheme ? AppColors.white : AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700),
          centerTitle: true,
        ),

        // Card and background theme customization
        cardTheme: CardTheme(
          elevation: 2,
          color: themeProvder.getDarkTheme
              ? AppColors.darkCardBackground
              : AppColors.white,
        ),
        scaffoldBackgroundColor: themeProvder.getDarkTheme
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        canvasColor: themeProvder.getDarkTheme
            ? AppColors.darkCardBackground
            : AppColors.searchLightColor,
        indicatorColor:
            themeProvder.getDarkTheme ? AppColors.white : AppColors.black,
        unselectedWidgetColor: themeProvder.getDarkTheme
            ? AppColors.darkUnselect
            : AppColors.lightUnselect,
        primaryColorLight: AppColors.black,
        brightness:
            themeProvder.getDarkTheme ? Brightness.light : Brightness.dark,

        // Input decoration for dropdown menus
        dropdownMenuTheme: DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                filled: true,
                fillColor: themeProvder.getDarkTheme
                    ? AppColors.darkCardBackground
                    : AppColors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: themeProvder.getDarkTheme
                            ? AppColors.white
                            : AppColors.black,
                        width: 1),
                    borderRadius: BorderRadius.circular(15.r)))),

        // Progress indicator theme
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.white,
          circularTrackColor: AppColors.red,
          refreshBackgroundColor: AppColors.red,
        ),

        // Elevated button styling
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h))),

        // Hint color based on theme
        hintColor: themeProvder.getDarkTheme
            ? AppColors.darkHintText
            : AppColors.lightHintText,

        // Overall primary color customization
        primaryColor:
            themeProvder.getDarkTheme ? AppColors.white : AppColors.black);
  }

  List<SingleChildWidget> get providerAllList {
    return [
      ChangeNotifierProvider(
        create: (context) {
          return ThemeProvider();
        },
      ),
    ];
  }
}
