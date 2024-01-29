import 'package:user_app/const/const.dart';

class ThemePreFerence {
  static const themeStatue = "THEME_STATUS";

  setDartTheme({required bool value}) async {
    sharedPreference!.setBool(themeStatue, value);
  }

  bool getTheme() {
    return sharedPreference!.getBool(themeStatue) ?? false;
  }
}
