import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Constant{
  static Future<bool> onBackPressed() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static Widget appBar(String title, context){
    return AppBar(
      backgroundColor: Colors.green,
      centerTitle: true,
      title: Text(title),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
    );
  }
}