import 'package:flutter/material.dart';

class DocumentTemplate extends StatefulWidget {
  final index;
  DocumentTemplate(this.index);
  @override
  _DocumentTemplateState createState() => _DocumentTemplateState(index);
}

class _DocumentTemplateState extends State<DocumentTemplate> {
  final int index;
  _DocumentTemplateState(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document', style: TextStyle(fontSize: 18)),
      ),
      body: Center(
        child: Text(index.toString(),
            style: TextStyle(color: Colors.white, fontSize: 30)),
      ),
    );
  }
}
