import 'app_function.dart';
import 'app_string.dart';

class Validators {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppString.pleaseEnterField(AppString.enterEmailAddress);
    } else if (!AppsFunction.isValidEmail(email)) {
      return AppString.pleaseEnterField(AppString.validEmailAddress);
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppString.enterPassword;
    } else if (password.length < 6) {
      return AppString.validPassword;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.pleaseEnterField(AppString.name);
    }
    if (value.length <= 2) return AppString.nameMustbeLongerThenTow;
    return null;
  }

  static String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.enterConfirmPassword;
    } else if (value.length < 6) {
      return AppString.validConfirmPassword;
    }
    return null;
  }

  static String? validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return AppString.pleaseEnterField(fieldName);
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.pleaseEnterField(AppString.phone);
    }
    if (value.length != 11) return AppString.phoneNumberMustbeExactly11;
    return null;
  }
}
