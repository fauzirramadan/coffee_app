import 'dart:developer';

import 'package:coffe_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/nav_utils.dart';
import '../../utils/prefs_utils.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool? isLogin;
  void getSession() async {
    try {
      await Future.delayed(const Duration(seconds: 3), () async {
        await PrefsUtils().get("isLogin").then((value) {
          setState(() {
            isLogin = value;
          });
        });
        if (isLogin == true) {
          Nav.toAll(const HomePage());
        } else {
          Nav.toAll(LoginPage());
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void initState() {
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConfigColor.darkBrown,
      body: Center(
        child: Image.asset(
          'assets/images/coffee.png',
          height: 150,
        ),
      ),
    );
  }
}
