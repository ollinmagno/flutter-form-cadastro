import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final String hint;
  final BuildContext context;
  final TextEditingController controller;
  final bool obscure;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final int maxLength;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final FocusNode nextFocus;

  AppText(this.context, this.text, this.hint,
      {@required this.validator,
      this.controller,
      this.obscure = false,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: text,
        hintText: hint,
        hintStyle: const TextStyle(
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
