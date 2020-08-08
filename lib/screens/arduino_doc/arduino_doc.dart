import 'package:erobot_app/reusable_widget/widget_supplier.dart';
import 'package:flutter/material.dart';
import 'package:erobot_app/object_class/classes.dart';
import 'package:erobot_app/screens/arduino_doc/document_template.dart';

class ArduinoDoc extends StatelessWidget {
  final List<Doc> docs = [
    Doc('Arduino Documents', 'Learn how to build a robot', 0,
        'arduino_doc.png'),
    Doc('Arduino Documents', 'Learn how to build a robot', 1,
        'arduino_doc.png'),
    Doc('Arduino Documents', 'Learn how to build a robot', 2,
        'arduino_doc.png'),
    Doc('Arduino Documents', 'Learn how to build a robot', 3,
        'arduino_doc.png'),
    Doc('Arduino Documents', 'Learn how to build a robot', 4,
        'arduino_doc.png'),
    Doc('Arduino Documents', 'Learn how to build a robot', 5,
        'arduino_doc.png'),
    Doc('Arduino Documents', 'Learn how to build a robot', 6,
        'arduino_doc.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            Doc doc = docs[index];
            return _buildCard(
                doc.title, doc.describe, doc.index, context, doc.imagePath);
          }),
    );
  }

  Widget _buildCard(String title, String desription, int cardIndex,
      BuildContext context, String path) {
    final String pathlogo = 'arduino_logo.png';
    final String pathBack = 'arduino_doc.png';
    final double widtht = 30;
    final double heightt = 35;

    return Container(
      height: 145,
      child: Padding(
          padding: cardIndex == 0
              ? EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 7.0)
              : cardIndex == 4
                  ? EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 10.0)
                  : EdgeInsets.fromLTRB(18.0, 7.0, 18.0, 7.0),
          child: Stack(children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/home/$pathBack',
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned.fill(
              child: randBackground(cardIndex),
            ),
            Positioned.fill(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DocumentTemplate(cardIndex)));
                },
                splashColor: Color.fromRGBO(255, 255, 255, .2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              letterSpacing: .7),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          desription,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              letterSpacing: .5),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Image.asset('assets/$pathlogo',
                        width: widtht, height: heightt),
                    SizedBox(
                      height: 0,
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}
