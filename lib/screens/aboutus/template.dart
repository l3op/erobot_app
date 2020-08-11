import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:erobot_app/models/models.dart';
import 'package:erobot_app/data/events.dart';

class AboutTeamTemplate extends StatefulWidget {
  final int index; //ARTICLE INDEX FROM TeamReputation();
  AboutTeamTemplate(this.index);
  @override
  _AboutTeamTemplateState createState() => _AboutTeamTemplateState(index);
}

class _AboutTeamTemplateState extends State<AboutTeamTemplate> {
  final int index;
  _AboutTeamTemplateState(this.index);

  int _imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    Event eventData = event[index];
    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              //SLIVER APP BAR
              SliverAppBar(
                iconTheme: IconThemeData(color: Hexcolor('172634')),
                expandedHeight: 400,
                floating: false,
                pinned: true,
                //APP BAR BACKGROUND
                flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                        'assets/home/${eventData.imagePath[_imageIndex]}',
                        fit: BoxFit.cover)),
                //APP BAR
                title: Text(eventData.eventName,
                    style: TextStyle(
                        color: Hexcolor('172634'),
                        fontWeight: FontWeight.normal,
                        fontSize: 18)),
                bottom: eventCard(eventData),
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
                  //SECTION 1 - MEMORIES
                  sectionLabel('Memories'),
                  buildListView(0.55, 1, eventData),
                  paragraph(paragraph1),
                  SizedBox(height: 8),

                  //SECTION2 - PARTICIPATING MEMBERS
                  sectionLabel('Participating Members'),
                  buildListView(0.35, 2, eventData),
                  SizedBox(height: 8),

                  //SECTION 3 - ROBOT USED
                  sectionLabel('Robots used at the Event'),
                  buildListView(0.35, 3, eventData),
                  paragraph(paragraph2),
                  SizedBox(height: 5),

                  // AUTHOR
                  author('Suy Kosal'),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ));
  }

  //ALL METHODs STORE USED IN THIS TEMPLETE

  //SECTION LABEL TEXT
  Text sectionLabel(String text) {
    return Text(
      '   ' + text,
      style: TextStyle(
          color: Hexcolor('172634'), fontWeight: FontWeight.w500, fontSize: 18),
    );
  }

  //PARAGRAPH
  Padding paragraph(String paragraph) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Text(paragraph));
  }

  //AUTHOR
  RichText author(String author) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontFamily: 'Raleway',
            color: Color.fromRGBO(22, 31, 40, 1),
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
          children: <TextSpan>[
            TextSpan(text: '    '),
            TextSpan(text: 'Written by '),
            TextSpan(text: author, style: TextStyle(color: Hexcolor('03a0b0'))),
          ]),
    );
  }

  //EVENT CARD
  PreferredSize eventCard(Event eventAcc) {
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //EVENT IMAGE
                      Image.asset('assets/events/${eventAcc.eventPath}'),
                      SizedBox(
                        width: 10,
                      ),
                      //EVENT NAME AND TITLE
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //EVENT NAME
                                Text(
                                  eventAcc.eventName,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                                //EVENT DATE
                                Text(
                                  eventAcc.eventDate,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                index == 0
                                    ? Text(
                                        'Cancel due to Covid 19',
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      )
                                    : Text(''),
                                SizedBox(
                                  height: 10,
                                )
                              ]),
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  //IMAGE LIST WITH HORIZONTAL SCROLL
  Container buildListView(double widthContainer, int section, Event eventAcc) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: section == 1
              ? eventAcc.imagePath.length
              : section == 2 ? eventAcc.member.length : eventAcc.robot.length,
          itemBuilder: (context, index) {
            //CLICK TO CHANGE IMAGE (SECTION 1 ONLY)
            return GestureDetector(
              onTap: () {
                if (section == 1)
                  setState(() {
                    _imageIndex = index;
                  });
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 8, 2, 8),
                child: Container(
                  // IF == SECTION 1 => NO NAME ON IMAGE
                  child: section != 1
                      ? Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            ' ' +
                                (section == 2
                                    ? eventAcc.member[index]
                                    : eventAcc.robot[index]) +
                                ' ',
                            style: TextStyle(
                                backgroundColor: Hexcolor('03a0b0'),
                                color: Colors.white),
                          ),
                        )
                      : null,
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
                          image: AssetImage(section == 1
                              ? 'assets/home/${imagePath[index]}'
                              : section == 2
                                  ? 'assets/profiles/${eventAcc.memberPath[index]}'
                                  : 'assets/home/${eventAcc.robotPath[index]}'),
                          fit: BoxFit.cover)),
                ),
              ),
            );
          }),
    );
  }
}
