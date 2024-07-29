import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_bar_updated/rating_bar_updated.dart';
import 'package:smooth_rating_bar/smooth_rating_bar.dart';
import 'package:user_app/res/constants.dart';
import 'package:user_app/res/routes/routesname.dart';



class RattingScreen extends StatefulWidget {
  const RattingScreen({super.key, required this.sellerId});

  final String sellerId;

  @override
  State<RattingScreen> createState() => _RattingScreenState();
}

class _RattingScreenState extends State<RattingScreen> {
  @override
  void initState() {
    if (kDebugMode) {
      print(widget.sellerId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white54, borderRadius: BorderRadius.circular(6)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Rate This Seller",
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 22,
              ),
              RatingBar(
                onRatingChanged: (value) {
                  countStarRatting = value;
                  if (countStarRatting == 1) {
                    setState(() {
                      titleRating = "Very Bad";
                    });
                  }
                  if (countStarRatting == 2) {
                    setState(() {
                      titleRating = "Bad";
                    });
                  }
                  if (countStarRatting == 3) {
                    setState(() {
                      titleRating = "Good";
                    });
                  }
                  if (countStarRatting == 4) {
                    setState(() {
                      titleRating = "Very Good";
                    });
                  }
                  if (countStarRatting == 5) {
                    setState(() {
                      titleRating = "Excellent";
                    });
                  }
                },
                filledIcon: Icons.star,
                emptyIcon: Icons.star_border,
                halfFilledIcon: Icons.star_half,
                isHalfAllowed: true,
                aligns: Alignment.centerLeft,
                filledColor: Colors.green,
                emptyColor: Colors.redAccent,
                halfFilledColor: Colors.amberAccent,
                size: 48,
              ),
              SmoothRatingBar(
                rating: countStarRatting,
                starSize: 50,
                starCount: 5,
                color: Colors.black,
                starPadding: const EdgeInsets.symmetric(horizontal: 7),
                onRatingCallback: (value) {
                  countStarRatting = value;
                  if (kDebugMode) {
                    print(countStarRatting);
                  }
                  if (countStarRatting == 1) {
                    setState(() {
                      titleRating = "Very Bad";
                    });
                  }
                  if (countStarRatting == 2) {
                    setState(() {
                      titleRating = "Bad";
                    });
                  }
                  if (countStarRatting == 3) {
                    setState(() {
                      titleRating = "Good";
                    });
                  }
                  if (countStarRatting == 4) {
                    setState(() {
                      titleRating = "Very Good";
                    });
                  }
                  if (countStarRatting == 5) {
                    setState(() {
                      titleRating = "Excellent";
                    });
                  }
                },
              ),
              // SmoothStarRating(
              //     allowHalfRating: false,
              //     onRated: (value) {
              //       countStarRatting = value;
              //       setState(() {});
              //     },
              //     starCount: 5,
              //     rating: countStarRatting,
              //     size: 40.0,
              //     isReadOnly: true,
              //     color: Colors.green,
              //     borderColor: Colors.green,
              //     spacing: 0.0),
              const Text("Bangladesh"),
              const SizedBox(
                height: 22,
              ),
              Text(
                titleRating,
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purpleAccent),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 14)),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection("seller")
                        .doc(widget.sellerId)
                        .get()
                        .then((value) {
                      if (kDebugMode) {
                        print(value.data()!["bangladesh  alo"]);
                      }
                      if (value.data()!["rating"] == 0.0) {
                        if (kDebugMode) {
                          print(value.data()!["rating"]);
                        }
                        FirebaseFirestore.instance
                            .collection("seller")
                            .doc(widget.sellerId)
                            .update({"rating": countStarRatting});
                      } else {
                        double pastRating = value.data()!["rating"];
                        double newRating = (pastRating + countStarRatting) / 2;
                        FirebaseFirestore.instance
                            .collection("seller")
                            .doc(widget.sellerId)
                            .update({"rating": newRating});
                      }
                      Fluttertoast.showToast(msg: "Rated Succefully");
                      setState(() {
                        countStarRatting = 0.0;
                        titleRating = "";
                      });
                      Navigator.pushNamed(context, RoutesName.mainPage,
                          arguments: 0);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => MainPage(index: 0),
                      //     ));
                    });
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }
}
