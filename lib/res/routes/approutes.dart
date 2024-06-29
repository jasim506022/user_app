import 'package:get/get.dart';

import '../../auth/forgetpasswordpage.dart';
import '../../auth/signinpage.dart';
import '../../auth/signuppage.dart';
import '../../page/cart/cartpage.dart';
import '../../page/main/mainpage.dart';
import '../../page/search/searchpage.dart';
import '../../page/splash/onboardingpage.dart';
import '../../page/splash/splashpage.dart';
import 'routesname.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RoutesName.initailRoutes, page: () => const SplashPage()),
        GetPage(name: RoutesName.signPage, page: () => const SignInPage()),
        GetPage(name: RoutesName.signupPage, page: () => const SignUpPage()),
        GetPage(name: RoutesName.mainPage, page: () => const MainPage()),
        GetPage(
            name: RoutesName.onBaordingPage,
            page: () => const OnboardingPage()),
        GetPage(
            name: RoutesName.forgetPassword,
            page: () => const ForgetPasswordPage()),
        GetPage(name: RoutesName.cartPage, page: () => const CartPage()),
        GetPage(name: RoutesName.searchPage, page: () => const SearchPage()),
      ];
}
