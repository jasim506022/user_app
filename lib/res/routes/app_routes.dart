import 'package:get/get.dart';

import '../../bindings/on_boarding_binding.dart';
import '../../bindings/search_binding.dart';
import '../../bindings/splash_binding.dart';
import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';

import '../../view/bill_andress/address_page.dart';
import '../../view/bill_andress/billl_page.dart';
import '../../view/bill_andress/place_order_page.dart';
import '../../view/cart/cart_page.dart';
import '../../view/main/main_page.dart';
import '../../view/order/history_page.dart';
import '../../view/order/order_delivery_page.dart';
import '../../view/order/order_detail_page.dart';
import '../../view/order/order_page.dart';
import '../../view/product/product_details_page.dart';
import '../../view/product/product_page.dart';
import '../../view/profile/edit_profile_page.dart';
import '../../view/profile/profile_screen.dart';
import '../../view/search/search_page.dart';
import '../../view/splash/onboarding_screen.dart';
import '../../view/splash/splash_screen.dart';
import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: RoutesName.initailRoutes,
            page: () => const SplashScreen(),
            binding: SplashBinding()),
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
            page: () => const OnboardingScreen(),
            binding: OnBoardingBinding()),
        GetPage(
            name: RoutesName.forgetPassword,
            page: () => const ForgetPasswordPage()),
        GetPage(name: RoutesName.cartPage, page: () => const CartPage()),
        GetPage(
            name: RoutesName.searchPage,
            page: () => const SearchPage(),
            binding: SearchBinding()),
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
          page: () => const EditProfilePage(),
        ),
        GetPage(
          name: RoutesName.deliveryScreen,
          page: () => const OrderDeliveryPage(),
        ),
        GetPage(
          name: RoutesName.orderDetailsPage,
          page: () => const OrderSummaryPage(),
        ),
        GetPage(
          name: RoutesName.orderPage,
          page: () => const OrderScreen(),
        ),
        GetPage(
          name: RoutesName.historyPage,
          page: () => const HistoryScreen(),
        )
      ];
}
