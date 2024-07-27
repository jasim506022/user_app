import '../res/appasset/image_asset.dart';
import 'onboardmodel.dart';

class OnBoardData {
  static List<OnboardModel> onboarddataList() => [
        OnboardModel(
          img: ImagesAsset.firstImageOnboard,
          text: "Welcome",
          desc:
              "Welcome to best online grocery store. Here you will find all the groceries at one place.",
        ),
        OnboardModel(
          img: ImagesAsset.secondImageOnboard,
          text: "Fresh Fruits & Vegetables",
          desc:
              "Buy farm fresh fruits & vegetables online at the best & affordable prices.",
        ),
        OnboardModel(
          img: ImagesAsset.thirdImageOnboard,
          text: "Quick & Fast Delivery",
          desc:
              "We offers speedy delivery of your groceries, bathroom supplies, baby care products, pet care items, stationary, etc within 30minutes at your doorstep.",
        )
      ];
}
