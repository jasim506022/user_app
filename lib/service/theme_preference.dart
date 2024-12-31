import '../res/app_constant.dart';

class ThemePreFerence {
  static const themeStatue = "THEME_STATUS";

  setDartTheme({required bool value}) async {
    AppConstant.sharedPreference!.setBool(themeStatue, value);
  }

  bool getTheme() {
    return AppConstant.sharedPreference!.getBool(themeStatue) ?? false;
  }
}
