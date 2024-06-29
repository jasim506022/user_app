import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/res/routes/approutes.dart';
import 'bindings/initial_binding.dart';
import 'res/routes/routesname.dart';
import 'res/gobalcolor.dart';
import 'service/provider/cart_product_counter_provider.dart';
import 'res/constants.dart';
import 'service/provider/category_provider.dart';
import 'service/provider/image_upload_provider.dart';
import 'service/provider/imageaddremoveprovider.dart';
import 'service/provider/loading_provider.dart';
import 'service/provider/searchtextprovider.dart';
import 'service/provider/theme_provider.dart';
import 'service/provider/totalamountrpovider.dart';

void main() async {
  Stripe.publishableKey = publishKey;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  sharedPreference = await SharedPreferences.getInstance();
  isviewed = sharedPreference!.getInt(onBoardingSharedPre);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// OnboardingRepository
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Material(
      child: MultiProvider(
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
      ),
    );
  }

  ThemeData themeData(ThemeProvider themeProvder) {
    return ThemeData(
        iconTheme:
            IconThemeData(color: themeProvder.getDarkTheme ? white : black),
        appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: themeProvder.getDarkTheme ? white : black),
          backgroundColor: themeProvder.getDarkTheme
              ? backgroundDarkColor
              : backgroundLightColor,
          titleTextStyle: GoogleFonts.roboto(
              color: themeProvder.getDarkTheme ? white : black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        // Scaffold Background Color
        scaffoldBackgroundColor: themeProvder.getDarkTheme
            ? backgroundDarkColor
            : backgroundLightColor,
        //Card Color
        cardColor: themeProvder.getDarkTheme ? cardDarkColor : white,
        //CanvasColor
        canvasColor:
            themeProvder.getDarkTheme ? cardDarkColor : searchLightColor,
        // Indicator Color
        indicatorColor: themeProvder.getDarkTheme
            ? indicatorColorDarkColor
            : indicatorColorightColor,
        primaryColorDark: white,
        primaryColorLight: black,

        // Hint Color
        hintColor: themeProvder.getDarkTheme ? hintDarkColor : hintLightColor,
        //brightness
        // brightness:
        //     themeProvder.getDarkTheme ? Brightness.light : Brightness.dark,
        // Primary

        primaryColor: themeProvder.getDarkTheme ? white : black);
  }

  List<SingleChildWidget> get providerAllList {
    return [
      ChangeNotifierProvider(
        create: (context) {
          return CategoryProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return SearchTextProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return CartProductCountProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return TotalAmountProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return ImageUploadProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return LoadingProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return ThemeProvider();
        },
      ),
      ChangeNotifierProvider(
        create: (context) {
          return ImageAddRemoveProvider();
        },
      ),
    ];
  }
}
