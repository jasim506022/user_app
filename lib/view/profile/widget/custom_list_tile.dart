import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:user_app/res/apps_text_style.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor ?? Theme.of(context).primaryColor,
        size: 25.h,
      ),
      trailing: IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).primaryColor,
            size: 20.h,
          )),
      title: Text(title,
          style: AppsTextStyle.largeBoldText
              .copyWith(color: iconColor ?? Theme.of(context).primaryColor)),
    );
  }
}
