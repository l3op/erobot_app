import 'package:erobot_app/screens/aboutus/template.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    Key key,
    @required this.name,
    @required this.role,
    @required this.pathIMG,
    @required this.index,
    @required this.context,
  }) : super(key: key);

  final String name;
  final String role;
  final String pathIMG;
  final int index;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 0.0),
      child: Container(
          //CARD CONTAINER
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
          height: 85,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                //EVENT LOGO
                Image.asset('assets/events/$pathIMG'),
                SizedBox(
                  width: 10,
                ),
                //EVENT INFO
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //EVENT NAME
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          //EVENT ROLE
                          Text(
                            role,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ]),

                    //READ MORE BUTTON
                    Container(
                      width: MediaQuery.of(context).size.width * 0.625,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            height: 28,
                            child: FlatButton(
                                splashColor: index == 1
                                    ? Colors.lightBlue
                                    : index == 2
                                        ? Colors.green
                                        : Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                color: Hexcolor('161F28'),
                                onPressed: () {
                                  print('see more clicked $index');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AboutTeamTemplate(index)));
                                },
                                child: Text(
                                  'Read More',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
