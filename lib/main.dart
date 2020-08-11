import 'config/palette.dart';
import 'package:erobot_app/screens.dart';
import 'package:flutter/material.dart';

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
        '/joinus': (context) => JoinUs()
      },
    ));
