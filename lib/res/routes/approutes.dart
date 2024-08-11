import 'package:get/get.dart';
import 'package:user_app/bindings/login_binding.dart';
import 'package:user_app/bindings/sign_up_binding.dart';
import 'package:user_app/view/product/details_product_page.dart';
import 'package:user_app/view/product/product_page.dart';

import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';

import '../../view/cart/cart_page.dart';
import '../../view/main/main_page.dart';
import '../../view/search/searchpage.dart';
import '../../view/splash/onboardingpage.dart';
import '../../view/splash/splashpage.dart';
import 'routesname.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RoutesName.initailRoutes, page: () => const SplashPage()),
        GetPage(name: RoutesName.signPage, page: () => const SignInPage(), binding: LoginBinding()),
        GetPage(name: RoutesName.signupPage, page: () => const SignUpPage(), binding: SignUpBinding()),
        GetPage(name: RoutesName.mainPage, page: () => const MainPage()),
        GetPage(
            name: RoutesName.onBaordingPage,
            page: () => const OnboardingPage()),
        GetPage(
            name: RoutesName.forgetPassword,
            page: () => const ForgetPasswordPage()),
        GetPage(name: RoutesName.cartPage, page: () => const CartPage()),
        GetPage(name: RoutesName.searchPage, page: () => const SearchPage()),
        GetPage(name: RoutesName.productPage, page: () => const ProductPage(),),
        GetPage(name: RoutesName.productDestailsPage, page: () => const ProductDetailsPage(),)
      ];
}
