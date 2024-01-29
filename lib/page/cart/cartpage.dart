import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_app/const/utils.dart';
import '../../const/cartmethod.dart';
import '../../const/const.dart';
import '../../const/gobalcolor.dart';
import '../../const/textstyle.dart';
import '../../model/productsmodel.dart';
import '../../service/database/firebasedatabase.dart';
import '../../service/provider/totalamountrpovider.dart';
import '../../widget/empty_widget.dart';
import '../bill/billlscreen.dart';
import 'cartwidget.dart';
import 'dotlineprinter.dart';
import 'loadingcardwidget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<int>? productQuantityListFromCartList;

  double totalAmount = 0.0;
  double deliveryAmount = 50;

  @override
  void initState() {
    totalAmount = 0;
    Provider.of<TotalAmountProvider>(context, listen: false).setAmount(0);
    productQuantityListFromCartList =
        CartMethods.separteProductQuantityUserCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    Textstyle textstyle = Textstyle(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Theme.of(context).brightness));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Cart Item")),
      body: sharedPreference!.getStringList("cartlist")!.length == 1 &&
              sharedPreference!.getStringList("cartlist")!.first == "initial"
          ? const EmptyWidget(
              image: "asset/payment/empty.png",
              title: "No Cart Avaiable",
            )
          : Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .55,
                  child: StreamBuilder(
                    stream: FirebaseDatabase.cartSellerSnapshot(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'No User Available',
                        );
                      } else if (snapshot.hasError) {
                        return EmptyWidget(
                          image: 'asset/payment/empty.png',
                          title: 'Error Occure: ${snapshot.error}',
                        );
                      }
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var sellerId = snapshot.data!.docs[index]["name"];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: RichText(
                                      text: TextSpan(
                                          style: textstyle.largestText,
                                          children: [
                                        const TextSpan(text: "Seller Name:\t"),
                                        TextSpan(
                                          text: sellerId,
                                          style: textstyle.largestText
                                              .copyWith(color: red),
                                        )
                                      ])),
                                ),
                                Flexible(
                                  child: StreamBuilder(
                                    stream:
                                        FirebaseDatabase.cartProductSnapshot(),
                                    builder: (context, productSnashot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const LoadingCardWidget();
                                      } else if (productSnashot.hasData) {
                                        return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount:
                                              productSnashot.data!.docs.length,
                                          itemBuilder: (context, itemIndex) {
                                            ProductModel productModel =
                                                ProductModel.fromMap(
                                                    productSnashot
                                                        .data!.docs[itemIndex]
                                                        .data());

                                            if (itemIndex == 0) {
                                              totalAmount = 0;
                                              totalAmount = totalAmount +
                                                  (globalMethod.productPrice(
                                                          productModel
                                                              .productprice!,
                                                          productModel.discount!
                                                              .toDouble()) *
                                                      productQuantityListFromCartList![
                                                          itemIndex]);
                                            } else {
                                              totalAmount = totalAmount +
                                                  (globalMethod.productPrice(
                                                          productModel
                                                              .productprice!,
                                                          productModel.discount!
                                                              .toDouble()) *
                                                      productQuantityListFromCartList![
                                                          itemIndex]);
                                            }

                                            if (snapshot.data!.docs.length -
                                                    1 ==
                                                itemIndex) {
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback(
                                                      (timeStamp) {
                                                Provider.of<TotalAmountProvider>(
                                                        context,
                                                        listen: false)
                                                    .setAmount(totalAmount);
                                              });
                                            }
                                            return CardWidget(
                                              productModel: productModel,
                                              itemQunter:
                                                  productQuantityListFromCartList![
                                                      itemIndex],
                                              index: itemIndex + 1,
                                            );
                                          },
                                        );
                                      }
                                      return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: 3,
                                          itemBuilder: (context, itemIndex) {
                                            return const LoadingCardWidget();
                                          });
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }

                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height * .35,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: utils.bottomTotalBill,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Consumer<TotalAmountProvider>(
                      builder: (context, value, child) {
                        totalAmount += value.getAmount;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total Amount",
                                    style: textstyle.mediumText600.copyWith(
                                        color: Theme.of(context).hintColor)),
                                Text(
                                  "Tk ${value.getAmount.toString()}",
                                  style: textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Delivery Charge",
                                    style: textstyle.mediumText600.copyWith(
                                        color: Theme.of(context).hintColor)),
                                Text(
                                  deliveryAmount.toString(),
                                  style: textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Carry Bag Charge",
                                  style: textstyle.mediumText600.copyWith(
                                      color: Theme.of(context).hintColor),
                                ),
                                Text(
                                  "0.00",
                                  style: textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Adjust the width as needed
                              child: CustomPaint(
                                painter: DottedLinePainter(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                                ),
                                Text(
                                  "${value.getAmount + deliveryAmount}",
                                  style: textstyle.mediumTextbold.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BillPage(),
                                    ));
                              },
                              child: Container(
                                height: 60,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: greenColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text(
                                  "Continue",
                                  style: textstyle.mediumTextbold
                                      .copyWith(color: white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
