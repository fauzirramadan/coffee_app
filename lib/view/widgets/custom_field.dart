import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/theme.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function()? onTap;
  final String? hint;
  final bool? obscure;
  final bool? isReadOnly;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomField(
      {super.key,
      this.controller,
      this.hint,
      this.onTap,
      this.obscure,
      this.isReadOnly,
      this.suffixIcon,
      this.inputFormatters,
      this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      validator: (value) {
        if (value!.isEmpty) {
          return "Must be fill";
        } else if (inputType == TextInputType.number &&
            value.contains(RegExp(r'^[a-z A-Z]+$'))) {
          return "invalid, just number";
        } else {
          return null;
        }
      },
      onTap: onTap,
      readOnly: isReadOnly ?? false,
      controller: controller,
      obscureText: obscure ?? false,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
          hintText: hint,
          fillColor: ConfigColor.lightBrown,
          suffixIcon: suffixIcon,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none)),
    );
  }
}
