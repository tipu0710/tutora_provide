import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../home_page.dart';

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image.asset("assets/logo.png", height: 150,),
        ),
      )
    );
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), (){
      Navigator.pushAndRemoveUntil(context, PageTransition(
          type: PageTransitionType.fade,
          child: HomePage(),
          alignment: Alignment.center,
          duration: Duration(milliseconds: 1500)), (Route<dynamic> route) => false);
    });
    super.initState();
  }
}