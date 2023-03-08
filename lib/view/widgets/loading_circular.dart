import 'package:coffe_app/utils/theme.dart';
import 'package:flutter/material.dart';

class LoadingCircular extends StatelessWidget {
  const LoadingCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
          backgroundColor: ConfigColor.lightBrown,
          child: CircularProgressIndicator(
            color: ConfigColor.primaryColor,
          )),
    );
  }
}
