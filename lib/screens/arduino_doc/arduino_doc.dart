import 'package:erobot_app/widgets/layerscard.dart';
import 'package:flutter/material.dart';
import 'package:erobot_app/models/models.dart';
import 'package:erobot_app/data/arduino_docs.dart';
import 'package:erobot_app/screens/arduino_doc/document_template.dart';

class ArduinoDoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final Doc doc = docs[index];
            return ThreeLayerCard(
              title: doc.title,
              desription: doc.describe,
              cardIndex: doc.index,
              path: 'assets/home/${doc.imagePath}',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DocumentTemplate(doc.index)));
              },
              isCenter: true,
            );
          }),
    );
  }
}
