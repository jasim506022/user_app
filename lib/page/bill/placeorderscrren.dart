import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:user_app/const/approutes.dart';
import 'package:user_app/const/const.dart';

import '../../const/gobalcolor.dart';
import '../../service/provider/cartprovider.dart';
import '../../const/textstyle.dart';
import '../main/mainpage.dart';

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
    Textstyle textstyle = Textstyle(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your order is confirmed",
            style: textstyle.largestText.copyWith(fontSize: 24),
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
                  backgroundColor: greenColor,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30)),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRouters.mainPage, (route) => false,
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
                    textstyle.largestText.copyWith(color: white, fontSize: 20),
              ))
        ],
      ),
    );
  }
}
