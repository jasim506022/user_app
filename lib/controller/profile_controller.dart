import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/repository/profile_repository.dart';

import '../model/profilemodel.dart';
import '../res/app_function.dart';
import '../res/constants.dart';

class ProfileController extends GetxController {
  final ProfileRepository _profileRepository;

  ProfileController(this._profileRepository);

  getUserInformationSnapshot() async {
    var snapshot = await _profileRepository.getUserInformationSnapshot();

    if (snapshot.exists) {
      ProfileModel profileModel = ProfileModel.fromMap(snapshot.data()!);
      if (profileModel.status == "approved") {
        sharedPreference = await SharedPreferences.getInstance();
        await sharedPreference!.setString("uid", profileModel.uid!);
        await sharedPreference!.setString("email", profileModel.email!);
        await sharedPreference!.setString("name", profileModel.name!);
        await sharedPreference!.setString("imageurl", profileModel.imageurl!);
        await sharedPreference!.setString("phone", profileModel.phone!);
        List<String> list =
            profileModel.cartlist!.map((e) => e.toString()).toList();
        await sharedPreference!.setStringList("cartlist", list);
      } else {
        AppsFunction.flutterToast(msg: "User Doesn't Exist");
      }
    }
  }
}
