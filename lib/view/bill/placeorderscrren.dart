import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_app/res/routes/routesname.dart';
import 'package:user_app/res/constants.dart';

import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';


class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({
    super.key,
  });

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  void initState() {
    globalMethod.getUserInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Textstyle Textstyle = Textstyle(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your order is confirmed",
            style: Textstyle.largestText.copyWith(fontSize: 24),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Thank you for shopping with JU Grocery",
            style: GoogleFonts.roboto(
                color: Theme.of(context).primaryColor,
                fontSize: 22,
                fontWeight: FontWeight.normal),
          ),
          Image.asset("asset/payment/orderconfirm.png"),
          const SizedBox(
            height: 4,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:AppColors. greenColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesName.mainPage, (route) => false,
                    arguments: 0);
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => MainPage(index: 0),
                //     ),
                //     (route) => false);
              },
              child: Text(
                "Home Page",
                style:
                    Textstyle.largestText.copyWith(color:AppColors. white, fontSize: 20),
              ))
        ],
      ),
    );
  }
}
