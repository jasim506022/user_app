import 'package:get/get.dart';
import 'package:user_app/view/bill_andress/billl_page.dart';
import 'package:user_app/view/bill_andress/place_order_page.dart';
import 'package:user_app/view/order/order_delivery_page.dart';
import 'package:user_app/view/order/order_detail_page.dart';
import 'package:user_app/view/product/product_details_page.dart';
import 'package:user_app/view/product/product_page.dart';
import 'package:user_app/view/profile/edit_profile_scrren.dart';
import 'package:user_app/view/profile/profile_screen.dart';

import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';

import '../../view/bill_andress/address_page.dart';
import '../../view/cart/cart_page.dart';
import '../../view/main/main_page.dart';
import '../../view/search/search_page.dart';
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
          page: () => const PlaceOrderPage(),
        ),
        GetPage(
          name: RoutesName.profileScreen,
          page: () => const ProfileScreen(),
        ),
        GetPage(
          name: RoutesName.editProfileScreen,
          page: () => const EditProfileScreen(),
        ),
        GetPage(
          name: RoutesName.deliveryScreen,
          page: () => const OrderDeliveryScreen(),
        ),
        GetPage(
          name: RoutesName.orderDetailsPage,
          page: () => const OrderSummaryPage(),
        )
      ];
}
