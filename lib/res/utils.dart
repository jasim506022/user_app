import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_colors.dart';

import '../service/provider/theme_provider.dart';

class Utils {
  static BuildContext get context => Get.context!;

  static ThemeData get theme => Theme.of(context);

  static bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  static Color get textFeildColor => getTheme
      ? AppColors.white.withOpacity(.9)
      : AppColors.black.withOpacity(.1);

  static Color get getColor => getTheme ? Colors.white : Colors.black;

  static Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;
  static Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;
  static Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;

  static Color get green300 =>
      getTheme ? Colors.green.shade800 : Colors.green.shade300;
  static Color get green100 =>
      getTheme ? Colors.green.shade600 : Colors.green.shade100;

  static Color get green200 =>
      getTheme ? Colors.green.shade700 : Colors.green.shade200;

  static Color? get green50 =>
      getTheme ? AppColors.darkCardBackground : Colors.green[50];

  static Color? get profileTextColor =>
      getTheme ? Colors.black87 : Colors.black54;

  static Color? get bottomTotalBill => getTheme
      ? AppColors.darkCardBackground
      : AppColors.accentGreen.withOpacity(.1);

  static Color? get categoryUnselectBackground => getTheme
      ? AppColors.darkCardBackground
      : const Color.fromARGB(255, 238, 236, 236);

  static Color? get categoryUnSelectTextColor => getTheme
      ? AppColors.white.withOpacity(.7)
      : AppColors.black.withOpacity(.8);

  static Color? get categorySelectBackground =>
      getTheme ? AppColors.accentGreen : AppColors.black;
}
