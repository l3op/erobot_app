import 'package:erobot_app/models/models.dart';
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
  List<IRremoteSetting> setting, settingTMP;
  _IRremoterSettingState(this.setting);

  @override
  Widget build(BuildContext context) {
    settingTMP = setting;
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting', style: TextStyle(fontSize: 18)),
        //RESET TO DEFAUL BUTTON
        actions: [],
      ),
      body: ScrollConfiguration(
        //ScrollConfiguration IS USED TO HIDE SCROLL EFFECT (WHITE EFFECT)
        behavior: ScrollBehavior()
          ..buildViewportChrome(context, null, AxisDirection.down),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                            resetDefaultHex();
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
                            resetDefaultChar();
                          }),
                    ),
                  ],
                ),
              ),
            ),
            ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: setting.length,
                itemBuilder: (context, index) {
                  IRremoteSetting settings = setting[index];
                  return buildSetting(context, settings.name, settings.describe,
                      settings.value, index);
                }),
          ],
        ),
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

  //RESET TO INITIAL SETTING
  void reset() {
    for (int i = 0; i < setting.length; i++) {
      setting[i].value = settingTMP[i].value;
    }
  }

  //RESET TO DEFAULT CHARACTER SETTING
  void resetDefaultChar() {
    List<String> _defaultChar = [
      'M',
      'P',
      'C',
      'p',
      'n',
      'Y',
      'v',
      'V',
      'E',
      'T',
      'O',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '0'
    ];
    print("${_defaultChar.length} vs ${setting.length}");
    for (int i = 0; i < setting.length; i++) setting[i].value = _defaultChar[i];
    setState(() {});
  }

  //RESET TO DEFAULT HEX SETTING
  void resetDefaultHex() {
    List<String> _defaultHex = [
      '0xFFA25D',
      '0xFFE21D',
      '0xFF629D',
      '0xFF22DD',
      '0xFF02FD',
      '0xFFC23D',
      '0xFFE01F',
      '0xFFA857',
      '0xFF906F',
      '0xFFB04F',
      '0xFF9867',
      '0xFF30CF',
      '0xFF18E7',
      '0xFF7A85',
      '0xFF10EF',
      '0xFF38C7',
      '0xFF5AA5',
      '0xFF42BD',
      '0xFF4AB5',
      '0xFF52AD',
      '0XFF6897',
    ];
    for (int i = 0; i < setting.length; i++) setting[i].value = _defaultHex[i];
    setState(() {});
  }

  Padding buildSetting(context, final String title, final String describe,
      final String _value, final int index) {
    return Padding(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: index == 0 ? 10 : 10,
          bottom: index == setting.length - 1 ? 20 : 0),
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
            buildShowModalBottomSheet(context, _value);
          },
          child: Row(
            children: [
              Text(_value, style: TextStyle(color: Colors.white, fontSize: 17)),
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

    void changeValue(value) {
      print('cam!');
      if (value != '' && _btnTMP != value) {
        for (int i = 0; i < setting.length; i++) {
          if (setting[i].value == _btnTMP) {
            if (!isDubicateValue(value)) {
              setState(() {
                setting[i].value = value;
                print('changed value to ${setting[i].value}');
              });
            } else if (isDubicateValue(value)) {
              Toast.show("Cannot save, dublicated value '$value'", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
            }
          }
        }
      } else {
        Toast.show("Cannot save!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
    }

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
                  onFieldSubmitted: (value) {
                    changeValue(value);
                  },
                ),
              ),
            ),
          );
        });
  }
}
