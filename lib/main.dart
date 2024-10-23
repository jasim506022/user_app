import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/res/apps_text_style.dart';

import 'bindings/initial_binding.dart';
import 'res/app_colors.dart';
import 'res/constant/string_constant.dart';
import 'res/routes/app_routes.dart';
import 'res/routes/routes_name.dart';
import 'res/constants.dart';
import 'service/provider/theme_provider.dart';

void main() async {
  Stripe.publishableKey = publishKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  sharedPreference = await SharedPreferences.getInstance();
  isviewed = sharedPreference!.getInt(StringConstant.onBoardingSharedPre);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
                initialRoute: RoutesName.initailRoutes,
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
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
              color: themeProvder.getDarkTheme
                  ? AppColors.white
                  : AppColors.black),
          backgroundColor: themeProvder.getDarkTheme
              ? AppColors.backgroundDarkColor
              : AppColors.backgroundLightColor,
          titleTextStyle: GoogleFonts.roboto(
              color:
                  themeProvder.getDarkTheme ? AppColors.white : AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700),
          centerTitle: true,
        ),
        // Scaffold Background Color
        scaffoldBackgroundColor: themeProvder.getDarkTheme
            ? AppColors.backgroundDarkColor
            : AppColors.backgroundLightColor,
        //Card Color
        cardColor: themeProvder.getDarkTheme
            ? AppColors.cardDarkColor
            : AppColors.white,
        //CanvasColor
        canvasColor: themeProvder.getDarkTheme
            ? AppColors.cardDarkColor
            : AppColors.searchLightColor,
        // Indicator Color
        indicatorColor: themeProvder.getDarkTheme
            ? AppColors.indicatorColorDarkColor
            : AppColors.indicatorColorightColor,
        primaryColorDark: AppColors.white,
        primaryColorLight: AppColors.black,

        // Hint Color
        hintColor: themeProvder.getDarkTheme
            ? AppColors.hintDarkColor
            : AppColors.hintLightColor,
        //brightness
        // brightness:
        //     themeProvder.getDarkTheme ? Brightness.light : Brightness.dark,
        // Primary

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


/*

*/