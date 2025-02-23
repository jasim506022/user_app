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
  ThemeData _buildThemeData(ThemeProvider themeProvider) {
    // Determine if the app is in dark theme mode
    var isDarkTheme = themeProvider.getDarkTheme;
    return ThemeData(

        // (Modify and Add comments)
        dialogTheme: DialogTheme(
            backgroundColor: isDarkTheme ? AppColors.cardDark : AppColors.white,
            titleTextStyle: GoogleFonts.poppins(
                color: isDarkTheme ? AppColors.white : AppColors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold),
            contentTextStyle: GoogleFonts.poppins(
                color: isDarkTheme
                    ? AppColors.white.withOpacity(.7)
                    : AppColors.black.withOpacity(.7),
                fontSize: 15.sp,
                fontWeight: FontWeight.normal)),

        // App Bar Theme (Modify)
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: isDarkTheme ? AppColors.white : AppColors.black,
          ),
          backgroundColor: isDarkTheme
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          titleTextStyle: GoogleFonts.roboto(
            color: isDarkTheme ? AppColors.white : AppColors.black,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),

        // Divider (Modify)
        dividerTheme: DividerThemeData(
          color: isDarkTheme ? AppColors.hintTextDark : AppColors.hintTextlight,
          thickness: 2,
        ),

        // Modify
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.white,
          linearTrackColor: AppColors.red,
          circularTrackColor: AppColors.red,
          refreshBackgroundColor: AppColors.red,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          color: isDarkTheme ? AppColors.cardDark : AppColors.white,
        ),
        scaffoldBackgroundColor:
            isDarkTheme ? AppColors.backgroundDark : AppColors.backgroundLight,
        canvasColor:
            isDarkTheme ? AppColors.cardDark : AppColors.searchColorLight,
        indicatorColor: isDarkTheme ? AppColors.white : AppColors.black,
        unselectedWidgetColor:
            isDarkTheme ? AppColors.unselectDark : AppColors.unselectList,
        primaryColorLight: AppColors.black,
        brightness: isDarkTheme ? Brightness.light : Brightness.dark,

        // Input decoration for dropdown menus
        dropdownMenuTheme: DropdownMenuThemeData(
            inputDecorationTheme: InputDecorationTheme(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                filled: true,
                fillColor: isDarkTheme ? AppColors.cardDark : AppColors.white,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: isDarkTheme ? AppColors.white : AppColors.black,
                        width: 1),
                    borderRadius: BorderRadius.circular(15.r)))),
        // Modify
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: AppColors.accentGreen,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r))),
        ),

        // Hint color based on theme
        hintColor:
            isDarkTheme ? AppColors.hintTextDark : AppColors.hintTextlight,

        // Overall primary color customization
        primaryColor: isDarkTheme ? AppColors.white : AppColors.black);
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
