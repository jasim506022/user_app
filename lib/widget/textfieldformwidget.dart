import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/constants.dart';

// ignore: must_be_immutable
class TextFieldFormWidget extends StatefulWidget {
  TextFieldFormWidget(
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

  @override
  State<TextFieldFormWidget> createState() => _TextFieldFormWidgetState();
}

class _TextFieldFormWidgetState extends State<TextFieldFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: mq.height * .012),
      child: TextFormField(
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
              color: Theme.of(context).primaryColor),
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
