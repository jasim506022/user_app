import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/constants.dart';
import '../res/utils.dart';

// ignore: must_be_immutable
class TextFormFieldWidget extends StatefulWidget {
  TextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      this.autofocus = false,
      this.obscureText = false,
      this.isShowPassword = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines = 1,
      this.enabled = true,
      this.textInputType = TextInputType.text,
      this.onChanged,
      this.validator});
  final String hintText;
  final TextEditingController controller;
  bool? autofocus;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  int? maxLines;
  bool? obscureText;
  bool? isShowPassword;
  bool? enabled;
  final String? Function(String?)? validator;
  Function(String)? onChanged;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    Utils utils = Utils(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * .012),
      child: TextFormField(
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          controller: widget.controller,
          autofocus: widget.autofocus!,
          maxLines: widget.maxLines,
          validator: widget.validator,
          obscureText: widget.obscureText!,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: widget.enabled!
                  ? Theme.of(context).primaryColor
                  : utils.profileTextColor),
          decoration: globalMethod.textFormFielddecoration(
              hintText: widget.hintText,
              isShowPassword: widget.isShowPassword!,
              obscureText: widget.obscureText!,
              function: () {
                widget.obscureText = !widget.obscureText!;
                setState(() {});
              })),
    );
  }
}
