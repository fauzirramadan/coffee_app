import 'package:flutter/material.dart';

import '../../utils/theme.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? title;
  const PrimaryButton({super.key, this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: ConfigColor.primaryColor,
      child: Text(
        title ?? "",
        style: const TextStyle(
            fontWeight: FontWeight.w600, color: Colors.white, fontSize: 16),
      ),
    );
  }
}
