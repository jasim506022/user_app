import 'package:shared_preferences/shared_preferences.dart';

import 'paymentmodel.dart';

int? isviewed;

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

const List<String> list = <String>['Home', 'Office', 'Other'];

const List<String> unitList = <String>[
  'Per Kg',
  'Per Dozen',
  'Litter',
  'Pc',
  'Pcs',
];

// Blank Profile Image
String blankProfileImage =
    "https://firebasestorage.googleapis.com/v0/b/grocery-app-4ca36.appspot.com/o/blank%2Fno-profile-picture-15257%20(1).png?alt=media&token=8c031928-1578-4826-8289-0e3f62751627";

String image =
    "https://ecdn.dhakatribune.net/contents/cache/images/400x225x1/uploads/media/2023/08/09/Khaleda-Zia-f6577f837e7d75115d637f8664cb65e9.jpeg?jadewits_media_id=914";

String publishKey =
    'pk_test_51NxWNQAVUbXW3f6RWMGhMJhUO0udDaNswK3RRuIo817qEyN28xcXHMTPHIOnj27ah0giitHaEsgqvHOxbcoNbAWC00Z6GYb1Rv';

// late Size mq;

double countStarRatting = 0.0;
String titleRating = "";

List<PaymentModel> paymentList = [
  PaymentModel(icon: "asset/payment/visa.png", title: "Card"),
  PaymentModel(icon: "asset/payment/bkash.png", title: "Bkash"),
];

enum Payment { card, bkash }
