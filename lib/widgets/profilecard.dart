import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String role;
  final String image;
  final Function onTGpressed;
  final Function onFBpressed;

  const ProfileCard(
      {Key key,
      this.name,
      this.role,
      this.image,
      this.onTGpressed,
      this.onFBpressed})
      : super(key: key);

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
                //IMAGE OF MEMBERS
                Image.asset('assets/profiles/$image'),
                SizedBox(width: 10),
                //INFO OF MEMBERS
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //NAME AND ROLE
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          Text(
                            role,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        ]),
                    //SOCIAL MEDIA INFO
                    Container(
                      width: MediaQuery.of(context).size.width * 0.625,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          //TELEGRAM
                          ClipOval(
                            child: Material(
                              color: Hexcolor('161F28'),
                              child: InkWell(
                                splashColor: Colors.blue,
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.telegramPlane,
                                    size: 18,
                                    color: Colors.white,
                                  )),
                                ),
                                onTap: onTGpressed,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          //FACEBOOK
                          Container(
                            height: 28,
                            child: FlatButton.icon(
                                splashColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                color: Hexcolor('161F28'),
                                onPressed: onTGpressed,
                                icon: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Facebook',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          )
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
