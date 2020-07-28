import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String text;
  String hint;
  BuildContext context;
  TextEditingController controller;
  bool obscure;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  int maxLength;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppText(this.context, this.text, this.hint,
      {this.controller,
      this.obscure = false,
      this.validator,
      this.keyboardType,
      this.maxLength,
      this.textInputAction,
      this.focusNode,
      this.nextFocus,
      });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscure,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: 1,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        labelText: text,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 16,
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 20,
        ),
      ),
    );
  }
}
