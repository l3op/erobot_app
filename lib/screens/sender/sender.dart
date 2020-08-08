import 'package:flutter/material.dart';

class Sender extends StatefulWidget {
  Sender({Key key}) : super(key: key);

  @override
  _SenderState createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sender', style: TextStyle(fontSize: 18)),
      ),
      body: Form(child: Container(
        child: Column(
          children:<Widget>[
            TextField(
              decoration: InputDecoration(
                counterText: '',
              ),
            )   
          ]
        ),
      )),
    );
  }
}
