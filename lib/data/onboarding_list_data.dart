import '../res/app_asset/app_imges.dart';
import '../model/onboard_model.dart';
import '../res/app_string.dart';

class OnBoardingListData {
  static List<OnboardModel> getOnboardingData() => [
        OnboardModel(
          image: AppImages.onboardingFirstImage,
          title: AppString.welcome,
          description: AppString.firstOnboardingDescription,
        ),
        OnboardModel(
          image: AppImages.onboardingSecondImage,
          title: AppString.fresshFruits,
          description: AppString.secondOnboardingDescription,
        ),
        OnboardModel(
          image: AppImages.onboardingThirdImage,
          title: AppString.quickDelivery,
          description: AppString.thirdOnboardingDescription,
        )
      ];
}
