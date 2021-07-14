import 'package:flutter/material.dart';
import 'package:sampling/screens/list/all_list_tesebaki.dart';
import 'package:sampling/screens/list/export_list.dart';
import 'package:sampling/screens/login_page.dart';
import 'package:sampling/screens/splash_page.dart';
import './screens/introduction.dart';
import './screens/home_page.dart';
import 'screens/list/exported_list.dart';
import 'screens/register_tesebaki.dart';
import 'screens/signup_page.dart';

void main() {
  runApp(MaterialApp(
    home: SplashPage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(fontFamily: "Nunito"),
    routes: {
      '/login': (context) => Login(),
      '/home': (context) => HomeLanding(),
      '/introduction': (context) => IntroPage(),
      '/register': (context) => AddTesebaki(),
      '/signup': (context) => SignUp(),
      '/splash': (context) => SplashPage(),
      '/all_list': (context) => AllList(),
      '/exported': (context) => ExportedList(),
      '/export': (context) => ExportList(),
    },
  ));
}
