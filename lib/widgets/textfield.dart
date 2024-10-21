import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? suffixIcon;
  final TextInputType keyboardtype;
  final String? Function(String?)? validator;

  const TextBox(
      {Key? key,
      required this.controller,
      required this.labelText,
      this.suffixIcon,
      required this.keyboardtype,
      required this.validator // mark as final and required
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardtype, // place keyboardType here
      decoration: InputDecoration(
        labelText: labelText,
        suffixIcon: suffixIcon, // use suffixIcon
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: validator,
    );
  }
}
