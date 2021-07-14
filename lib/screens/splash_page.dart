import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sampling/constant/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _firstLaunch();
  }

  _firstLaunch() async {
    SharedPreferences lS = await SharedPreferences.getInstance();

    if (lS.getBool('ranOnce') != null) {
      _checkLoggedIn();
    } else {
      lS.setBool('ranOnce', true); //ran once set true
      Navigator.pushNamed(context, '/introduction'); //then show the guide
    }
  }

  _checkLoggedIn() async {
    SharedPreferences lS = await SharedPreferences.getInstance();

    print('Logged In in splash screen : ${lS.getBool('logged_in')}');

    if (lS.getBool('logged_in') != null) {
      if (lS.getBool('logged_in') == true) {
        Navigator.pushNamed(context, '/home');
      } else {
        Navigator.pushNamed(context, '/login');
      }
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // _checkLoggedIn();
    return Scaffold(
        body: Container(
            height: size.height,
            width: size.width,
            decoration: kGradientboxDecoration,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'WELCOME',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Evange Counter',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 50),
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ))
        //   body: Container(
        //     height: size.height,
        //     width: size.width,
        //     decoration: kGradientboxDecoration,
        //     child: Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: <Widget>[
        //           Image(
        //             image: AssetImage("assets/images/logite.png"),
        //             height: 300,
        //           ),
        //           SizedBox(height: 30),
        //           CircularProgressIndicator(
        //             backgroundColor: Colors.white,
        //           ),
        //           SizedBox(height: 20),
        //           Text(
        //             "Loading",
        //             style: TextStyle(
        //               color: Colors.blue,
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),
        //
        );
  }
}
