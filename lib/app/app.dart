import 'package:coffe_app/utils/theme.dart';
import 'package:coffe_app/view/pages/home.dart';
import 'package:coffe_app/view/pages/login.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee App',
      navigatorKey: navKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: ConfigColor.primaryColor,
      ),
      home: LoginPage(),
    );
  }
}
