import 'package:erobot_app/object_class/classes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

class IRremoterSetting extends StatefulWidget {
  final List<IRremoteSetting> _setting;
  IRremoterSetting(this._setting);

  @override
  _IRremoterSettingState createState() => _IRremoterSettingState(_setting);
}

class _IRremoterSettingState extends State<IRremoterSetting> {
  final List<IRremoteSetting> setting;
  _IRremoterSettingState(this.setting);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting', style: TextStyle(fontSize: 18)),
        //RESET TO DEFAUL BUTTON
        actions: [
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color.fromRGBO(255, 255, 255, .1)),
                child: Row(
                  children: [
                    Text(' Reset to '),
                    Container(
                      width: 51,
                      height: 30,
                      child: FlatButton(
                          color: Color.fromRGBO(255, 255, 255, .2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          splashColor: Colors.white,
                          child: Text(
                            'Hex',
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {
                            print('hex');
                          }),
                    ),
                    Text(' '),
                    Container(
                      width: 78,
                      height: 30,
                      child: FlatButton(
                          color: Color.fromRGBO(255, 255, 255, .2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          splashColor: Colors.white,
                          child: Text(
                            'Character',
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {
                            print('char');
                          }),
                    ),
                  ],
                ),
              ))
        ],
      ),
      body: ScrollConfiguration(
        //ScrollConfiguration IS USED TO HIDE SCROLL EFFECT (WHITE EFFECT)
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: ListView.builder(
            itemCount: setting.length,
            itemBuilder: (context, index) {
              IRremoteSetting set = setting[index];
              return buildSetting(
                  context, set.name, set.describe, set.value, index);
            }),
      ),
    );
  }

  bool isContainPNG(String value) {
    int k = 0, t = 0;
    String path = 'png';
    if (value.length > 4)
      for (int i = value.length - 3; i < value.length; i++) {
        if (path[k] == value[i]) t++;
        k++;
      }
    if (t == 3) return true ?? false;
    return false;
  }

  Padding buildSetting(context, final String title, final String describe,
      final String value, final int index) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: index == 0 ? 20 : 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            Container(
              width: 40,
              child: !isContainPNG(title)
                  ? Text(title,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 5, right: 15, top: 5, bottom: 5),
                      child: Image.asset('assets/sender/$title'),
                    ),
            ),
            SizedBox(width: 10),
            Text(
              ':  $describe',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
        InkWell(
          splashColor: null,
          onTap: () {
            buildShowModalBottomSheet(context, value);
          },
          child: Row(
            children: [
              Text(value, style: TextStyle(color: Colors.white, fontSize: 17)),
              SizedBox(
                width: 10,
              ),
              FaIcon(FontAwesomeIcons.angleRight, size: 20, color: Colors.white)
            ],
          ),
        )
      ]),
    );
  }

  bool isDubicateValue(String value) {
    for (int i = 0; i < setting.length; i++) {
      if (value == setting[i].value) return true;
    }
    return false;
  }

  Future buildShowModalBottomSheet(BuildContext context, String btnValue) {
    String _btnTMP = btnValue;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
                  autofocus: true,
                  initialValue: btnValue,
                  decoration: InputDecoration(
                    counterText: '',
                  ),
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  maxLines: 1,
                  onChanged: (value) {
                    print("changing to " + value);
                    if (_btnTMP != value && isDubicateValue(value)) {
                      Toast.show("Dublicated value '$value'", context,
                          duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
                    }
                  },
                  onFieldSubmitted: (value) {},
                ),
              ),
            ),
          );
        });
  }
}
