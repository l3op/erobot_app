import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/screens/arduino_doc/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:erobot_app/import/data.dart';
import 'package:erobot_app/import/models.dart';
import 'package:video_player/video_player.dart';

class DocumentTemplate extends StatefulWidget {
  final index;
  DocumentTemplate(this.index);
  @override
  _DocumentTemplateState createState() => _DocumentTemplateState(index);
}

class _DocumentTemplateState extends State<DocumentTemplate> {
  final int index;
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  _DocumentTemplateState(this.index);
  @override
  Widget build(BuildContext context) {
    Document docs = doc[index];
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              //SLIVER APP BAR
              SliverAppBar(
                iconTheme: IconThemeData(color: Palette.bigstone),
                expandedHeight: 400,
                floating: false,
                pinned: true,
                //APP BAR BACKGROUND
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset('assets/home/arduino_doc.png',
                        fit: BoxFit.cover)),
                //APP BAR
                title: Text('Document',
                    style: TextStyle(
                        color: Palette.shark,
                        fontWeight: FontWeight.normal,
                        fontSize: 18)),
                bottom: silverTitle(),
              ),
            ];
          },
          //HIDE SCROLL END EFFECT
          body: ScrollConfiguration(
            behavior: ScrollBehavior()
              ..buildViewportChrome(context, null, AxisDirection.down),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //SECTION 1 - DEMO VIDEO
                  sectionLabel('Demo Video'),
                  ChewieListItem(
                      videoPlayerController: VideoPlayerController.asset(
                          "assets/video/video1.mp4")),
                  SizedBox(height: 8),

                  //SECTION2 - COMPONENT USED
                  sectionLabel('Component Used'),
                  buildListView(0.35, 2, docs),
                  SizedBox(height: 8),

                  //SECTION 3 - SOFTWARE USED
                  sectionLabel('Software Used'),
                  buildListView(0.35, 3, docs),
                  SizedBox(height: 5),

                  for (int i = 0; i < steps.length; i++)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          sectionLabel("Step ${i + 1}"),
                          paragraph(steps[i].text),
                          steps[i].picture != null
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 5, 15, 5),
                                  child: Image.asset(
                                    'assets/document/step/${steps[i].picture}',
                                    fit: BoxFit.fitWidth,
                                  ),
                                )
                              : Container(),
                        ]),
                  sectionLabel('Tutorial Video'),
                  ChewieListItem(
                      videoPlayerController: VideoPlayerController.asset(
                          "assets/video/video1.mp4")),
                ],
              ),
            ),
          ),
        ));
  }

  //EVENT CARD
  PreferredSize silverTitle() {
    return PreferredSize(
      preferredSize: Size.fromHeight(
          kToolbarHeight), //kToolbarHeight has same constant that AppBar uses.
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 10.0, 0.0, 10.0),
              child: Container(
                  height: 85,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //EVENT NAME
                        Text(
                          'How to change Name and Password of HC-05',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Author(
                          author: 'Suy Kosal',
                          fontSize: 12,
                        ),
                        SizedBox(height: 5),
                        // DATE
                        Text(
                          '14th May 2020',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }

  //IMAGE LIST WITH HORIZONTAL SCROLL
  Container buildListView(double widthContainer, int section, Document doc) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: section == 2 ? components.length : software.length,
          itemBuilder: (context, index) {
            //CLICK TO CHANGE IMAGE (SECTION 1 ONLY)
            return Padding(
              padding: const EdgeInsets.fromLTRB(14, 8, 2, 8),
              child: Container(
                // COMPONENT OR SOFTWARE USED
                child: Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    ' ' +
                        (section == 2
                            ? components[index].name
                            : software[index].name) +
                        ' ',
                    style: TextStyle(
                        backgroundColor: Palette.blue_pacific,
                        color: Colors.white),
                  ),
                ),
                width: MediaQuery.of(context).size.width * widthContainer,
                //BACKGROUND IMAGE WITH SHADOW
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                    image: DecorationImage(
                        image: AssetImage(section == 2
                            ? 'assets/document/components/${components[index].path}'
                            : 'assets/document/software/${software[index].path}'),
                        fit: BoxFit.cover)),
              ),
            );
          }),
    );
  }
}

//SECTION LABEL TEXT
Text sectionLabel(String text) {
  return Text(
    '   ' + text,
    style: TextStyle(
        color: Palette.shark, fontWeight: FontWeight.w500, fontSize: 18),
  );
}

//PARAGRAPH
Padding paragraph(String paragraph) {
  return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Text(paragraph));
}
