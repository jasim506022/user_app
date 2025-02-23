import 'app_string.dart';

/// **Validation Utility Class**
/// Provides consistent validation logic throughout the app.
class Validators {
  /// **Checks if a string is null or empty after trimming.**
  static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;

  /// **Predefined regex patterns for validation.**
  static final RegExp _emailPattern =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  static final RegExp _namePattern = RegExp(r'^[a-zA-Z\s]+$');
  static final RegExp _productNamePattern = RegExp(r'^[a-zA-Z0-9 ]+$');
  static final RegExp _decimalPattern = RegExp(r'^\d+(\.\d{1,2})?$');

  /// **Validates an email address.**
  static String? validateEmail(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyEmail;
    if (!_emailPattern.hasMatch(trimmedValue!)) {
      return AppString.invalidEmailFormat;
    }
    return trimmedValue.length > 320 ? AppString.emailTooLong : null;
  }

  /// **Validates a password.**
  static String? validatePassword(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyPassword;
    if (trimmedValue!.length < 6) return AppString.passwordTooShort;
    if (!trimmedValue.contains(RegExp(r'[A-Z]'))) {
      return AppString.passwordUppercase;
    }
    if (!trimmedValue.contains(RegExp(r'[a-z]'))) {
      return AppString.passwordLowercase;
    }
    if (!trimmedValue.contains(RegExp(r'\d'))) return AppString.passwordNumber;
    return trimmedValue.length > 20 ? AppString.passwordTooLong : null;
  }

  /// **Validates confirm password.**
  static String? validateConfirmPassword(String? value, String password) {
    return _isEmpty(value)
        ? AppString.confirmPasswordRequired
        : (value!.trim() != password ? AppString.passwordMismatch : null);
  }

  /// **Validates a name (only letters & spaces).**
  static String? validateName(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyName;
    if (trimmedValue!.length < 2) return AppString.nameTooShort;
    if (trimmedValue.length > 50) return AppString.nameTooLong;
    return _namePattern.hasMatch(trimmedValue) ? null : AppString.nameInvalid;
  }

  /// **Validates a product name.**
  static String? validateProductName(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyProductName;
    if (trimmedValue!.length < 3) return AppString.productNameTooShort;
    if (trimmedValue.length > 100) return AppString.productNameTooLong;
    return _productNamePattern.hasMatch(trimmedValue)
        ? null
        : AppString.productNameInvalid;
  }

  /// **Validates a price.**
  static String? validatePrice(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyPrice;
    final price = double.tryParse(trimmedValue!);
    if (price == null || price <= 0 || price > 1000000) {
      return AppString.priceOutOfRange;
    }
    return _decimalPattern.hasMatch(trimmedValue)
        ? null
        : AppString.invalidPriceFormat;
  }

  /// **Validates a rating (1 to 5).**
  static String? validateRating(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyRating;
    final rating = double.tryParse(trimmedValue!);
    return (rating == null || rating < 1 || rating > 5)
        ? AppString.ratingOutOfRange
        : null;
  }

  /// **Validates a discount percentage (0-100).**
  static String? validateDiscount(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyDiscount;
    final discount = double.tryParse(trimmedValue!);
    if (discount == null || discount < 0 || discount > 100) {
      return AppString.discountOverLimit;
    }
    return _decimalPattern.hasMatch(trimmedValue)
        ? null
        : AppString.invalidDiscountFormat;
  }

  /// **Validates a product description.**
  static String? validateProductDescription(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyDescription;
    if (trimmedValue!.length < 10) return AppString.descriptionTooShort;
    if (trimmedValue.length > 1000) return AppString.descriptionTooLong;
    return null;
  }

  /// **Validates an address.**
  static String? validateAddress(String? value) {
    final trimmedValue = value?.trim();
    if (_isEmpty(trimmedValue)) return AppString.emptyAddress;
    if (trimmedValue!.length < 5) return AppString.addressTooShort;
    if (trimmedValue.length > 200) return AppString.addressTooLong;
    return null;
  }
}


/*
#: String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
#: !RegExp(r'[A-Z]').hasMatch(value)
!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)
#: RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value) == false
#:  double? discount = double.tryParse(value);
#: !RegExp(r'^\d+(\.\d{1,2})?$').hasMatch(value)

#:   static bool _isEmpty(String? value) => value?.trim().isEmpty ?? true;
  why use this instead of 
 if (value == null || value.trim().isEmpty) {
      return AppString.emptyEmail;
    } 
#: final price = double.tryParse(trimmedValue!);



*/