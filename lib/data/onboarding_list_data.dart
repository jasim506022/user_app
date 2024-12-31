import '../res/app_asset/image_asset.dart';
import '../model/onboard_model.dart';

class OnBoardingListData {
  static List<OnboardModel> onboarddataList() => [
        OnboardModel(
          photo: ImagesAsset.firstImageOnboard,
          title: "Welcome",
          description:
              "Welcome to best online grocery store. Here you will find all the groceries at one place.",
        ),
        OnboardModel(
          photo: ImagesAsset.secondImageOnboard,
          title: "Fresh Fruits & Vegetables",
          description:
              "Buy farm fresh fruits & vegetables online at the best & affordable prices.",
        ),
        OnboardModel(
          photo: ImagesAsset.thirdImageOnboard,
          title: "Quick & Fast Delivery",
          description:
              "We offers speedy delivery of your groceries, bathroom supplies, baby care products, pet care items, stationary, etc within 30minutes at your doorstep.",
        )
      ];
}
