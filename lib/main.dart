import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/res/app_string.dart';

import 'bindings/initial_binding.dart';
import 'res/app_colors.dart';
import 'res/app_constant.dart';
import 'res/routes/app_routes.dart';
import 'res/routes/routes_name.dart';
import 'service/provider/theme_provider.dart';

void main() async {
  Stripe.publishableKey = AppConstant.publishKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AppConstant.sharedPreference = await SharedPreferences.getInstance();
  AppConstant.isViewed =
      AppConstant.sharedPreference!.getInt(AppString.onBoardingSharedPre);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Theme.of(context).brightness));
    return ScreenUtilInit(
      designSize: const Size(450, 851), //582
      builder: (_, child) {
        return MultiProvider(
          providers: providerAllList,
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvder, child) {
              return GetMaterialApp(
                initialBinding: InitialBinding(),
                debugShowCheckedModeBanner: false,
                theme: themeData(themeProvder),
                initialRoute: AppRoutesName.splashScreen,
                getPages: AppRoutes.appRoutes(),
              );
            },
          ),
        );
      },
    );
  }

  ThemeData themeData(ThemeProvider themeProvder) {
    return ThemeData(
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
        dialogBackgroundColor: themeProvder.getDarkTheme
            ? AppColors.darkBackground
            : AppColors.lightBackground,
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
        scaffoldBackgroundColor: themeProvder.getDarkTheme
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        cardColor: themeProvder.getDarkTheme
            ? AppColors.darkCardBackground
            : AppColors.white,
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
              borderRadius: BorderRadius.circular(15.r)),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        )),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.white,
          circularTrackColor: AppColors.red,
          refreshBackgroundColor: AppColors.red,
        ),
        // Hint Color
        hintColor: themeProvder.getDarkTheme
            ? AppColors.darkHintText
            : AppColors.lightHintText,
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
