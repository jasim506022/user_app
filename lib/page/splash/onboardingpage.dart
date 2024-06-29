import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/onboarding_controller.dart';

import '../../model/onboard_data.dart';
import '../../res/constants.dart';
import '../../res/gobalcolor.dart';
import '../../res/textstyle.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController(
      onBoardingRepository: Get.find(),
    ));

    final PageController pageController = PageController(initialPage: 0);

    Textstyle textstyle = Textstyle(context);
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0.0,
          actions: [
            TextButton(
                onPressed: () {
                  controller.completeOnboarding();
                },
                child: Text(
                  "Skip",
                  style: textstyle.largeText.copyWith(color: black),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mq.height * .044),
          child: PageView.builder(
            controller: pageController,
            itemCount: OnBoardData.onboarddataList().length,
            onPageChanged: (value) {
              controller.updateIndex(value);
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    OnBoardData.onboarddataList()[index].img,
                    height: mq.height * .411,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: mq.height * .013,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Container(
                                height: mq.height * .01,
                                width: mq.height * .01,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                decoration: BoxDecoration(
                                    color:
                                        controller.currentIndex.value == index
                                            ? red
                                            : black,
                                    shape: BoxShape.circle),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Text(
                    OnBoardData.onboarddataList()[index].text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: black),
                  ),
                  Text(OnBoardData.onboarddataList()[index].desc,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: black)),
                  InkWell(
                    onTap: () async {
                      if (index == OnBoardData.onboarddataList().length - 1) {}
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.bounceIn);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: mq.width * .066,
                          vertical: mq.height * .015),
                      decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.circular(mq.width * .033)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Next",
                            style: GoogleFonts.inter(
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                color: white),
                          ),
                          SizedBox(
                            width: mq.width * .04,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}
