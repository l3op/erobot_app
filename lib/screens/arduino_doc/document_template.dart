import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:flutter/material.dart';
import 'package:erobot_app/import/data.dart';
import 'package:erobot_app/import/models.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:video_player/video_player.dart';

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
    double sizes = components.length < 7 ? 900 : 500;
    return Scaffold(
      appBar: AppBar(
        title: Text('Document', style: TextStyle(fontSize: 18)),
      ),
      body: ScrollConfiguration(
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: ListView(
          children: [
            DocSection1(index: index),
            Container(
              margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              height: sizes,
              decoration: BoxDecoration(
                  color: Palette.appbar,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .3),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    )
                  ]),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Demo Video',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 10),
                    Container(
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(
                              'assets/home/arduino_doc.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                              child: Center(
                            child: FaIcon(FontAwesomeIcons.play,
                                color: Colors.white),
                          )),
                        ],
                      ),
                    ),
                    Text('Component Used',
                        style: TextStyle(
                            color: Colors.white, height: 2.5, fontSize: 20)),
                    SizedBox(
                      height: components.length < 5 ? 100 : 150,
                      child: IgnorePointer(
                        child: ListView.builder(
                            itemCount: components.length,
                            itemBuilder: (context, index) {
                              return Text('${components[index].name}',
                                  style: TextStyle(
                                      color: Palette.blue_pacific,
                                      fontSize: 16,
                                      height: 1.3));
                            }),
                      ),
                    ),
                    SizedBox(
                        height: components.length < 3
                            ? 130
                            : components.length < 5 ? 270 : 310,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: components.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  width: 110,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/document/components/${components[index].path}',
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                            })),
                    SizedBox(height: 10),
                    Text('Software used',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 10),
                    Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: components.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  width: 110,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/document/software/${components[index].path}',
                                      fit: BoxFit.cover,
                                    ),
                                  ));
                            })),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
