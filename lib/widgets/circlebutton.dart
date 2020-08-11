import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CircleButtonText extends StatelessWidget {
  const CircleButtonText({
    Key key,
    @required this.isShow,
    @required this.display,
    @required this.value,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  final bool isShow;
  final String display;
  final String value;
  final String color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Hexcolor(color)),
      child: IconButton(
          icon: Text(!isShow ? display : value,
              style: TextStyle(
                  color:
                      color != 'ffffff' ? Colors.white : Hexcolor('161f28'))),
          onPressed: onPressed),
    );
  }
}

class CircleButtonIcon extends StatelessWidget {
  const CircleButtonIcon({
    Key key,
    @required this.isShow,
    @required this.value,
    @required this.path,
    @required this.color,
    @required this.onPressed,
  }) : super(key: key);

  final bool isShow;
  final String value;
  final String path;
  final String color;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Hexcolor(color),
      ),
      child: IconButton(
          icon: !isShow
              ? Padding(
                  padding: EdgeInsets.all(path == 'playpause.png' ? 11.0 : 8.0),
                  child: Image.asset('assets/sender/$path'),
                )
              : Text(value, style: TextStyle(color: Colors.white)),
          onPressed: onPressed),
    );
  }
}