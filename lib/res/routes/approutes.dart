import 'package:get/get.dart';
import 'package:user_app/view/bill/billlscreen.dart';
import 'package:user_app/view/bill/placeorderscrren.dart';
import 'package:user_app/view/product/product_details_page.dart';
import 'package:user_app/view/product/product_page.dart';
import 'package:user_app/view/profile/editprofilescrren.dart';
import 'package:user_app/view/profile/profilescreen.dart';

import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';

import '../../view/bill/address_page.dart';
import '../../view/cart/cart_page.dart';
import '../../view/main/main_page.dart';
import '../../view/search/searchpage.dart';
import '../../view/splash/onboarding_page.dart';
import '../../view/splash/splash_page.dart';
import 'routesname.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(name: RoutesName.initailRoutes, page: () => const SplashPage()),
        GetPage(
            name: RoutesName.signPage,
            page: () => const SignInPage(),
            ),
        GetPage(
            name: RoutesName.signupPage,
            page: () => const SignUpPage(),
            ),
        GetPage(name: RoutesName.mainPage, page: () => const MainPage()),
        GetPage(
            name: RoutesName.onBaordingPage,
            page: () => const OnboardingPage()),
        GetPage(
            name: RoutesName.forgetPassword,
            page: () => const ForgetPasswordPage()),
        GetPage(name: RoutesName.cartPage, page: () => const CartPage()),
        GetPage(name: RoutesName.searchPage, page: () => const SearchPage()),
        GetPage(
          name: RoutesName.productPage,
          page: () => const ProductPage(),
        ),
        GetPage(
          name: RoutesName.productDestailsPage,
          page: () => const ProductDetailsPage(),
        ),
        GetPage(
          name: RoutesName.addressPage,
          page: () => const AddressPage(),
        ),
        GetPage(
          name: RoutesName.billPage,
          page: () => const BillPage(),
        ),
        GetPage(
          name: RoutesName.placeOrderScreen,
          page: () => const PlaceOrderScreen(),
        ),
        GetPage(
          name: RoutesName.profileScreen,
          page: () => const ProfileScreen(),
        ),
        GetPage(
          name: RoutesName.editProfileScreen,
          page: () => const EditProfileScreen(),
        )
      ];
}
