import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/const/paymentmodel.dart';

import 'method.dart';
import 'textstyle.dart';

SharedPreferences? sharedPreference;

GlobalMethod globalMethod = GlobalMethod();

const List<String> allCategoryList = <String>[
  "All",
  'Fruits',
  'Vegatables',
  'Dairy & Egg',
  'Dry & Canned',
  "Drinks",
  "Meat & Fish",
  "Candy & Chocolate"
];

const List<String> unitList = <String>[
  'Per Kg',
  'Per Dozen',
  'Litter',
  'Pc',
  'Pcs',
];

String image =
    "https://ecdn.dhakatribune.net/contents/cache/images/400x225x1/uploads/media/2023/08/09/Khaleda-Zia-f6577f837e7d75115d637f8664cb65e9.jpeg?jadewits_media_id=914";

String publishKey =
    'pk_test_51NxWNQAVUbXW3f6RWMGhMJhUO0udDaNswK3RRuIo817qEyN28xcXHMTPHIOnj27ah0giitHaEsgqvHOxbcoNbAWC00Z6GYb1Rv';

const List<String> list = <String>['Home', 'Office', 'Other'];

Size mqs(BuildContext context) {
  return MediaQuery.of(context).size;
}

late Size mq;

int? isviewed;

double countStarRatting = 0.0;
String titleRating = "";

List<PaymentModel> paymentList = [
  PaymentModel(icon: "asset/payment/visa.png", title: "Card"),
  PaymentModel(icon: "asset/payment/bkash.png", title: "Bkash"),
];

enum Payment { card, bkash }
