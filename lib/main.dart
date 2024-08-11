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
import 'res/app_colors.dart';
import 'res/routes/routesname.dart';
import 'res/constants.dart';
import 'service/provider/image_upload_provider.dart';
import 'service/provider/imageaddremoveprovider.dart';
import 'service/provider/loading_provider.dart';
import 'service/provider/searchtextprovider.dart';
import 'service/provider/theme_provider.dart';

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
  }

  ThemeData themeData(ThemeProvider themeProvder) {
    return ThemeData(
        iconTheme: IconThemeData(
            color:
                themeProvder.getDarkTheme ? AppColors.white : AppColors.black),
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
              fontSize: 18,
              fontWeight: FontWeight.bold),
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
          return SearchTextProvider();
        },
      ),
     
      // ChangeNotifierProvider(
      //   create: (context) {
      //     return TotalAmountProvider();
      //   },
      // ),
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

/*
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
import 'res/gobalcolor.dart';
import 'res/routes/routesname.dart';
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
            IconThemeData(color: themeProvder.getDarkTheme ?AppColors. white :AppColors. black),
        appBarTheme: AppBarTheme(
          iconTheme:
              IconThemeData(color: themeProvder.getDarkTheme ?AppColors. white :AppColors. black),
          backgroundColor: themeProvder.getDarkTheme
              ?AppColors. backgroundDarkColor
              : AppColors.backgroundLightColor,
          titleTextStyle: GoogleFonts.roboto(
              color: themeProvder.getDarkTheme ?AppColors. white :AppColors. black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          centerTitle: true,
        ),
        // Scaffold Background Color
        scaffoldBackgroundColor: themeProvder.getDarkTheme
            ?AppColors. backgroundDarkColor
            :AppColors. backgroundLightColor,
        //Card Color
        cardColor: themeProvder.getDarkTheme ?AppColors. cardDarkColor :AppColors. white,
        //CanvasColor
        canvasColor:
            themeProvder.getDarkTheme ?AppColors. cardDarkColor :AppColors. searchLightColor,
        // Indicator Color
        indicatorColor: themeProvder.getDarkTheme
            ?AppColors. indicatorColorDarkColor
            :AppColors. indicatorColorightColor,
        primaryColorDark:AppColors. white,
        primaryColorLight:AppColors. black,

        // Hint Color
        hintColor: themeProvder.getDarkTheme ?AppColors. hintDarkColor :AppColors. hintLightColor,
        //brightness
        // brightness:
        //     themeProvder.getDarkTheme ? Brightness.light : Brightness.dark,
        // Primary

        primaryColor: themeProvder.getDarkTheme ?AppColors. white :AppColors. black);
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
*/



/*


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutesName.initialRoutes,
      getPages: AppRoutes.appRoutes(),
    );
  }
}

class LoginRepository {
  // Example method
  void loginUser(String username, String password) {
    // Login logic here
  }
}

class SignUpRepository {
  // Example method
  void signUpUser(String username, String password) {
    // Sign up logic here
  }
}

class LoginController extends GetxController {
  final LoginRepository loginRepository;

  LoginController(this.loginRepository);

  // Example properties
  var username = ''.obs;
  var password = ''.obs;

  // Example method
  void login() {
    loginRepository.loginUser(username.value, password.value);
  }
}

class SignUpController extends GetxController {
  final SignUpRepository signUpRepository;

  SignUpController(this.signUpRepository);

  // Example properties
  var username = ''.obs;
  var password = ''.obs;

  // Example method
  void signUp() {
    signUpRepository.signUpUser(username.value, password.value);
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize global controllers and repositories here if needed
  }
}

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpRepository>(() => SignUpRepository());
    Get.lazyPut<SignUpController>(
        () => SignUpController(Get.find<SignUpRepository>()));
  }
}

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginRepository>(() => LoginRepository());
    Get.lazyPut<LoginController>(
        () => LoginController(Get.find<LoginRepository>()));
  }
}

class RoutesName {
  static const String initialRoutes = '/';
  static const String login = '/login';
  static const String signUp = '/sign-up';
}

class AppRoutes {
  static List<GetPage> appRoutes() {
    return [
      GetPage(
          name: RoutesName.initialRoutes,
          page: () => LoginPage(),
          binding: LoginBinding()),
      GetPage(
          name: RoutesName.login,
          page: () => LoginPage(),
          binding: LoginBinding()),
      GetPage(
          name: RoutesName.signUp,
          page: () => SignUpPage(),
          binding: SignUpBinding()),
    ];
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing LoginController instance
    final LoginController loginController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) => loginController.username.value = value,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              onChanged: (value) => loginController.password.value = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: loginController.login,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed(RoutesName.signUp),
              child: Text('Go to Sign Up Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing SignUpController instance
    final SignUpController signUpController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) => signUpController.username.value = value,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              onChanged: (value) => signUpController.password.value = value,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}




*/