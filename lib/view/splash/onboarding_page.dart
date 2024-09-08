import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/onboarding_controller.dart';

import '../../data/onboarding_list_data.dart';
import '../../res/app_colors.dart';
import '../../res/Textstyle.dart';
import 'package:user_app/model/onboardmodel.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnBoardingController controller = Get.find();

    final PageController pageController = PageController(initialPage: 0);
    final onboardData = OnBoardingListData.onboarddataList();

    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0.0,
          actions: [
            TextButton(
                onPressed: () {
                  controller.completeOnboarding();
                },
                child: Text(
                  "Skip",
                  style: Textstyle.largeText.copyWith(color: AppColors.black),
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: PageView.builder(
            controller: pageController,
            itemCount: onboardData.length,
            onPageChanged: (value) {
              controller.updateIndex(value);
            },
            itemBuilder: (context, index) {
              return _buildOnboarding(
                  onboardData, index, controller, pageController);
            },
          ),
        ));
  }

  Column _buildOnboarding(List<OnboardModel> onboardData, int index,
      OnBoardingController controller, PageController pageController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          onboardData[index].img,
          height: 0.411.sh,
          fit: BoxFit.fill,
        ),
        _buildIndicator(controller, onboardData.length),
        Text(
          onboardData[index].text,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 30.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.black),
        ),
        Text(onboardData[index].desc,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black)),
        InkWell(
          onTap: () async {
            if (index == onboardData.length - 1) {
              controller.completeOnboarding();
            }
            pageController.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.bounceIn);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 12.w),
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(15.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Next",
                  style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
                SizedBox(
                  width: 18.w,
                ),
                Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColors.white,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  SizedBox _buildIndicator(OnBoardingController controller, int itemCount) {
    return SizedBox(
      height: 12.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => Container(
                  height: 10.w,
                  width: 10.w,
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  decoration: BoxDecoration(
                      color: controller.currentIndex.value == index
                          ? AppColors.red
                          : AppColors.black,
                      shape: BoxShape.circle),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
