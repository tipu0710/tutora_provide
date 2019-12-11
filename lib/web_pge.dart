import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tutora_provide/home_page.dart';

class WebWidget extends StatefulWidget {
  final String url;

  const WebWidget({Key key, this.url = "https://tutorprovide.com/"})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WebWidget();
  }
}

class _WebWidget extends State<WebWidget> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool isInternet = true;
  @override
  void initState() {
    super.initState();
    checkInternet();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      checkInternetStatus(result);
    });
    flutterWebviewPlugin.onDestroy.listen((_) {
      Navigator.push(
          context,
          PageTransition(
              child: HomePage(),
              type: PageTransitionType.scale,
              alignment: Alignment.center,
              duration: Duration(seconds: 1)));
    });
    flutterWebviewPlugin.onHttpError.listen((_) {
      print("Error");
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isInternet? WebviewScaffold(
      url: widget.url,
      withJavascript: true,
      withZoom: false,
      allowFileURLs: true,
      hidden: true,
      scrollBar: false,
      initialChild: Container(
        color: Colors.white,
        child: Center(
          child: Center(
            child: SpinKitRipple(
              size: 150,
              itemBuilder: (_, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.green,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ): Scaffold(
      body: Center(
        child: Container(
          child: Image.asset("assets/internet.png", height: (MediaQuery.of(context).size.height*0.3),),
        ),
      ),
    );
  }

  void checkInternet() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isInternet = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isInternet = true;
      });
    } else{
      setState(() {
        isInternet = false;
      });
    }
  }

  void checkInternetStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          isInternet = true;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          isInternet = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          isInternet = false;
        });
        break;
      default:
        setState(() => isInternet = true);
        break;
    }
  }
}
