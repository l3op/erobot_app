import 'package:flutter/material.dart';

class ThreeLayerCard extends StatelessWidget {
  final String title;
  final String desription;
  final int cardIndex;
  final Function onPressed;
  final String path;
  final bool isCenter;

  const ThreeLayerCard(
      {Key key,
      @required this.title,
      @required this.desription,
      @required this.cardIndex,
      @required this.onPressed,
      @required this.path,
      this.isCenter = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pathlogo = 'mdi_bluetooth.png';
    double width = 15, height = 20, boxSize = 10;
    if (cardIndex == 0) {
      boxSize = 0;
      width = 30;
      height = 35;
      pathlogo = 'arduino_logo.png';
    }
    double left, top, right, bottom;
    left = top = right = bottom = 0;
    if (isCenter) {
      left = right = 18;
      if (cardIndex == 0) {
        top = 10;
        bottom = 7;
      }
      if (cardIndex == 4) {
        top = 7;
        bottom = 10;
      } else {
        top = bottom = 7;
      }
    } else if (!isCenter) {
      if (cardIndex == 0) {
        left = right = 18;
        top = bottom = 10;
      } else if (cardIndex.isEven) {
        left = 5;
        right = 18;
        bottom = 10;
      } else if (cardIndex.isOdd) {
        left = 18;
        right = 5.0;
        bottom = 10.0;
      }
    }

    return Container(
      height: 145,
      child: Padding(
          padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          child: Stack(children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(path, fit: BoxFit.cover)),
            ),
            Positioned.fill(
              child: randBackground(cardIndex),
            ),
            Positioned.fill(
              child: FlatButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14.0))),
                onPressed: onPressed,
                splashColor: const Color.fromRGBO(255, 255, 255, .2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
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
                    SizedBox(height: 10),
                    Image.asset('assets/mostused/$pathlogo',
                        width: width, height: height),
                    SizedBox(
                      height: boxSize,
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }
}

class TwoLayerCard extends StatelessWidget {
  const TwoLayerCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 7.0, 0, 7.0),
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    'assets/home/our_team.png',
                    fit: BoxFit.cover,
                  )),
            ),
            Positioned.fill(
              child: randBackground(3),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Erobot member!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
                  ),
                  Text(
                    'Join us now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget randBackground(int index) {
  int cardIndex = index % 5;

  //LIST OF COLOR
  var list = [
    '0_111_60.png',
    '249_167_62.png',
    '182_20_44.png',
    '3_160_176.png',
    '231_126_78.png',
  ];
  String indexColor = list[cardIndex];

  //DO THIS TO BE BETTER WHEN DECREASE COLOR PICTURE OPERCITY
  var color1 = [0, 111, 60];
  var color2 = [249, 167, 62];
  var color3 = [182, 20, 44];
  var color4 = [3, 160, 176];
  var color5 = [231, 126, 78];

  var colorRGBO;
  if (cardIndex == 0) colorRGBO = color1;
  if (cardIndex == 1) colorRGBO = color2;
  if (cardIndex == 2) colorRGBO = color3;
  if (cardIndex == 3) colorRGBO = color4;
  if (cardIndex == 4) colorRGBO = color5;

  return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.asset(
        'assets/colors/$indexColor',
        fit: BoxFit.cover,
        //DECREASE OPERCITY TO 0.8 WITH COLOR ABOVE
        color: Color.fromRGBO(colorRGBO[0], colorRGBO[1], colorRGBO[2], 0.8),
        colorBlendMode: BlendMode.modulate,
      ));
}
