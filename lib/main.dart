import 'dart:async';

//Packages
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/services.dart';

//Screens
import 'screens/root/root.dart';
import 'package:erobot_app/screens/sender/sender.dart';
import 'package:erobot_app/screens/ir_remoter/ir_remoter.dart';
import 'package:erobot_app/screens/feedback/feedback.dart';
import 'package:erobot_app/screens/login_page/login.dart';
import 'package:erobot_app/screens/farm_assistant/farm_assistant.dart';
import 'package:erobot_app/screens/login_page/joinus.dart';
import 'screens/feedback/feedback.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

//0xAARRGGBB
MaterialColor colorCustom = MaterialColor(0xFF172634, color);
MaterialColor colorCustom2 = MaterialColor(0xFF161F28, color);

void main() => runApp(MaterialApp(
      builder: (context, navigator) {
        var lang = Localizations.localeOf(context).languageCode;
        return Theme(
          data: ThemeData(
            fontFamily: lang == 'kh' ? 'Hanuman' : 'Raleway',
            primarySwatch: colorCustom,
            canvasColor: colorCustom2,
          ),
          child: navigator,
        );
      },
      theme: ThemeData(
        primarySwatch: colorCustom,
        canvasColor: colorCustom2,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/loginP': (context) => LoginPage(),
        '/farm_assistant': (context) => FarmAssistant(),
        '/sender': (context) => Sender(),
        '/ir_remote': (context) => IrRemoter(),
        '/feedback': (context) => FeedbackApp(),
        '/joinus': (context) => JoinUs(),
      },
    ));

//SPLASH SCREEN PAGE
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var _duration = Duration(seconds: 5);
    Timer(_duration, navigationPage);
    super.initState();
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        PageTransition(
            child: Root(),
            duration: Duration(milliseconds: 550),
            type: PageTransitionType.fade));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    SizedBox(
                      height: 250,
                    ),
                    Image.asset(
                      'assets/app_splash.png',
                      width: 150,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                          style: TextStyle(
                            color: Color.fromRGBO(22, 31, 40, 1),
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Raleway',
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: 'EDUCATION IS '),
                            TextSpan(
                                text: 'POWER',
                                style: TextStyle(
                                  color: Colors.red,
                                )),
                            TextSpan(text: '.')
                          ]),
                    ),
                  ])),
              Container(
                child: Column(children: <Widget>[
                  Text(
                    'Last published 30th Jul, 2020.',
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      color: Color.fromRGBO(22, 31, 40, .6),
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
