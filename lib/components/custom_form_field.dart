import 'package:flutter/material.dart';

import '../utils/app_theme/constants.dart';

typedef SubmitCallback(String value);

class CustomTextFormField extends StatelessWidget {

  String? hintText;
  String? labelText;
  TextStyle? style;
  FocusNode? focusNode;
  TextAlign? textAlign;
  TextEditingController? controller;
  SubmitCallback? onSubmitted;
  SubmitCallback? validator;
  TextInputAction? textInputAction;
  void Function(String) ?onSaved, onChange;
  String? initialValue;
  Widget? prefix;
  int? maxLines;
  double? borderRadius;
  bool? isEnabled;
  bool? autofocus;
  int? maxLength;
  AutovalidateMode? autoValidateMode;


  TextInputType? textInputType;
  bool isPassword = false;
  OutlineInputBorder formOutlineBorder = const OutlineInputBorder(
      borderSide: BorderSide(
          width: 0.0,
          color: Colors.transparent
      )
  );

  CustomTextFormField({Key? key,
    this.textInputType,
    this.textInputAction,
    this.initialValue,
    this.maxLength,
    this.controller,
    this.focusNode,
    this.textAlign,
    this.style,
    this.autofocus,
    this.onSubmitted,
    this.borderRadius,
    this.validator,
    this.isEnabled,
    this.labelText,
    this.hintText,
    this.prefix,
    this.maxLines,
    this.autoValidateMode,
    this.isPassword = false,
    this.onSaved,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus??false,
      style: style?? TextStyle(
        color: Theme.of(context).accentColor
      ),
      maxLines: maxLines,
      enabled: isEnabled,
      textAlign: textAlign ?? TextAlign.start,
      initialValue: initialValue,
      obscureText: isPassword,
      keyboardType: textInputType,
      validator: (value){
        return validator!(value!);
      },
      onSaved: (val) {onSaved!(val!);},
      onChanged: onChange,
      maxLength: maxLength,
      onFieldSubmitted: onSubmitted,
      focusNode: focusNode,
      controller: controller,
      textInputAction: textInputAction,
      autovalidateMode: autoValidateMode,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        filled: true,
        prefix: prefix,
        border: formOutlineBorder,
        counterText: '',
        labelStyle: AMUNETheme.bodyText2,
        hintStyle: AMUNETheme.bodyText2,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius??50),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius??50),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius??50),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0x00000000),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(borderRadius??50),
        ),
        fillColor:
        Theme.of(context).canvasColor,
        contentPadding:
        const EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),

      ),
    );
  }
}