import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/res/app_colors.dart';

import '../service/provider/theme_provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor => getTheme ? Colors.white : Colors.black;

  Color get baseShimmerColor =>
      getTheme ? Colors.grey.shade500 : Colors.grey.shade200;
  Color get highlightShimmerColor =>
      getTheme ? Colors.grey.shade700 : Colors.grey.shade400;
  Color get widgetShimmerColor =>
      getTheme ? Colors.grey.shade600 : Colors.grey.shade100;

  Color get green300 =>
      getTheme ? Colors.green.shade800 : Colors.green.shade300;
  Color get green100 =>
      getTheme ? Colors.green.shade600 : Colors.green.shade100;

  Color get green200 =>
      getTheme ? Colors.green.shade700 : Colors.green.shade200;

  Color? get green50 => getTheme ?AppColors. cardDarkColor : Colors.green[50];

  Color? get profileTextColor => getTheme ? Colors.white54 : Colors.black54;

  Color? get bottomTotalBill =>
      getTheme ?AppColors. cardDarkColor :AppColors. greenColor.withOpacity(.1);

  Color? get categoryUnselectBackground =>
      getTheme ?AppColors. cardDarkColor : const Color.fromARGB(255, 238, 236, 236);

  Color? get categoryUnSelectTextColor =>
      getTheme ?AppColors. white.withOpacity(.7) :AppColors. black;

  Color? get categorySelectBackground => getTheme ?AppColors. greenColor :AppColors. black;
}
