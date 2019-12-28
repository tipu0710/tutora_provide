import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tutora_provide/constant.dart';
import 'package:tutora_provide/custom_icon/my_flutter_app_icons.dart';
import 'package:tutora_provide/web_pge.dart';
import 'package:url_launcher/url_launcher.dart';


String msgUrl = "https://m.me/tutorprovide";
String youtubeUrl = "https://www.youtube.com/watch?v=JHROR1YMxwA";

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  double opacity = 0.85;
  List imgList = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
  ];


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Constant.onBackPressed,
      child: Scaffold(
        //appBar: Constant.appBar("Tutor Provide", context),
        body: Stack(
          children: <Widget>[
            CarouselSlider(
              items: getItem(),
              height: MediaQuery.of(context).size.height,
              aspectRatio: 1,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: Duration(seconds: 1),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(0.2),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Category(
                        "https://tutorprovide.com/",
                        backgroundColor: Colors.pink.withOpacity(opacity),
                        icon: MyIcons.home,
                        title: "HOME".toUpperCase(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Category(
                        "https://tutorprovide.com/login",
                        backgroundColor: Colors.deepOrange.withOpacity(opacity),
                        icon: MyIcons.login,
                        title: "Sign In".toUpperCase(),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Category(
                        "https://tutorprovide.com/register/tutor",
                        backgroundColor: Colors.purple.withOpacity(opacity),
                        icon: MyIcons.user_plus,
                        title: "Tutor \nRegistrtion".toUpperCase(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Category(
                        "https://tutorprovide.com/register",
                        backgroundColor: Colors.blueAccent.withOpacity(opacity),
                        icon: MyIcons.users,
                        title: "Guardian \nRegistrtion".toUpperCase(),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Category(
                        "https://tutorprovide.com/jobboard",
                        backgroundColor: Colors.green.withOpacity(opacity),
                        icon: MyIcons.book_open,
                        title: "Available \nTutions".toUpperCase(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Category(
                        "https://tutorprovide.com/whytutorprovide",
                        backgroundColor: Colors.teal.withOpacity(opacity),
                        icon: MyIcons.question_circle_o,
                        title: "Why us".toUpperCase(),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Category(
                        youtubeUrl,
                        backgroundColor: Colors.lime.withOpacity(opacity),
                        icon: Icons.ondemand_video,
                        title: "How to\nRegister".toUpperCase(),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Category(msgUrl,
                          backgroundColor: Colors.limeAccent.withOpacity(opacity),
                          icon: Icons.message,
                          title: "Contact".toUpperCase())
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    "Tutor Provide",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 3.0,
                          color: Colors.black38,
                        ),
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 3.0,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              height: 100.0,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                color: Colors.greenAccent,
                boxShadow: [new BoxShadow(blurRadius: 40.0)],
                borderRadius: new BorderRadius.vertical(
                    bottom: new Radius.elliptical(
                        MediaQuery.of(context).size.width, 100.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getItem() {
    return imgList.map((path) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            child: Image.asset(
              path,
              fit: BoxFit.cover,
            ),
          );
        },
      );
    }).toList();
  }
}

class Category extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;
  final String url;

  const Category(this.url,
      {Key key,
      @required this.icon,
      @required this.title,
      this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("Tap");
        if (url == youtubeUrl || url == msgUrl) {
          launchYoutube(url);
        } else {
          Navigator.push(
              context,
              PageTransition(
                  child: WebWidget(
                    url: url,
                  ),
                  type: PageTransitionType.scale,
                  alignment: Alignment.center,
                  duration: Duration(seconds: 1)));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.all(10.0),
        width: 150,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  launchYoutube(String url) async {
    await launch(url);
  }
}
