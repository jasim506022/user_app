import 'package:get/get.dart';

import '../../bindings/on_boarding_binding.dart';
import '../../bindings/search_binding.dart';
import '../../bindings/splash_binding.dart';

import '../../view/auth/forget_password_page.dart';
import '../../view/auth/sign_in_page.dart';
import '../../view/auth/sign_up_page.dart';

import '../../view/bill_andress/address_page.dart';
import '../../view/bill_andress/billing_page.dart';
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
import '../../view/profile/profile_page.dart';

import '../../view/search/search_page.dart';

import '../../view/splash/onboarding_page.dart';
import '../../view/splash/splash_page.dart';

import 'routes_name.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
            name: AppRoutesName.splashScreen,
            page: () => const SplashScreen(),
            binding: SplashBinding()),
        GetPage(
          name: AppRoutesName.signInPage,
          page: () => const SignInPage(),
        ),
        GetPage(
          name: AppRoutesName.signUpPage,
          page: () => const SignUpPage(),
        ),
        GetPage(name: AppRoutesName.mainPage, page: () => const MainPage()),
        GetPage(
            name: AppRoutesName.onbordingScreen,
            page: () => const OnboardingScreen(),
            binding: OnBoardingBinding()),
        GetPage(
            name: AppRoutesName.forgetPasswordPage,
            page: () => const ForgetPasswordScreen()),
        GetPage(name: AppRoutesName.cartPage, page: () => const CartPage()),
        GetPage(
            name: AppRoutesName.searchPage,
            page: () => const SearchPage(),
            binding: SearchBinding()),
        GetPage(
          name: AppRoutesName.productListPage,
          page: () => const ProductPage(),
        ),
        GetPage(
          name: AppRoutesName.productDetailsPage,
          page: () => const ProductDetailsPage(),
        ),
        GetPage(
          name: AppRoutesName.addressPage,
          page: () => const AddressPage(),
        ),
        GetPage(
          name: AppRoutesName.billPage,
          page: () => const BillingPage(),
        ),
        GetPage(
          name: AppRoutesName.orderConfirmationPage,
          page: () => const PlaceOrderPage(),
        ),
        GetPage(
          name: AppRoutesName.userProfilePage,
          page: () => const ProfileScreen(),
        ),
        GetPage(
          name: AppRoutesName.editProfilePage,
          page: () => const EditProfilePage(),
        ),
        GetPage(
          name: AppRoutesName.deliveryScreen,
          page: () => const OrderDeliveryPage(),
        ),
        GetPage(
          name: AppRoutesName.orderDetailsPage,
          page: () => const OrderSummaryPage(),
        ),
        GetPage(
          name: AppRoutesName.orderSummaryPage,
          page: () => const OrderScreen(),
        ),
        GetPage(
          name: AppRoutesName.orderHistoryPage,
          page: () => const HistoryScreen(),
        )
      ];
}
