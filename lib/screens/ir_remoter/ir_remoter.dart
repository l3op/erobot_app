import 'package:erobot_app/object_class/classes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:erobot_app/screens/ir_remoter/ir_remoter_setting.dart';

class IrRemoter extends StatefulWidget {
  IrRemoter({Key key}) : super(key: key);

  @override
  _IrRemoterState createState() => _IrRemoterState();
}

class _IrRemoterState extends State<IrRemoter> {
  bool isShow = false;

  String eq, one, two, three, four, five, six, seven, edge, nine, zero;
  String ch, chp, chm, prev, next, playpause, volp, volm, twohunp, onehunp;
  //twohunp, onehunp is 100+, 200+

  @override
  void initState() {
    super.initState();
    _loadCacheDate();
  }

  //REFERENCE: https://www.circuitbasics.com/arduino-ir-remote-receiver-tutorial/
  _loadCacheDate() {
    ch = '0xFF629D';
    chp = '0xFFE21D';
    chm = '0xFFA25D';
    prev = '0xFF22DD';
    next = '0xFF02FD';
    playpause = '0xFFC23D';
    volp = '0xFFA857';
    volm = '0xFFE01F';
    eq = '0xFF906F';
    twohunp = '0xFFB04F';
    onehunp = '0xFF9867';
    one = '0xFF30CF';
    two = '0xFF18E7';
    three = '0xFF7A85';
    four = '0xFF10EF';
    five = '0xFF38C7';
    six = '0xFF5AA5';
    seven = '0xFF42BD';
    edge = '0xFF4AB5';
    nine = '0xFF52AD';
    zero = '0XFF6897';
  }

  @override
  Widget build(BuildContext context) {
    List<IRremoteSetting> setting = [
      IRremoteSetting('CH-', 'Increase Channel', chm),
      IRremoteSetting('CH+', 'Decrease Channel', chp),
      IRremoteSetting('CH', 'Channel', ch),
      IRremoteSetting('prev.png', 'Previus', prev),
      IRremoteSetting('next.png', 'Next', next),
      IRremoteSetting('playpause.png', 'Play or Pause', playpause),
      IRremoteSetting('volm.png', 'Volumn Down', volm),
      IRremoteSetting('volp.png', 'Volumn Up', volp),
      IRremoteSetting('100+', 'Increase 100', onehunp),
      IRremoteSetting('200+', 'Increase 200', twohunp),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IR Remoter',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
              icon: Icon(
                isShow ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isShow = !isShow;
                });
              }),
          IconButton(
              icon: Icon(Icons.bluetooth_disabled, color: Colors.white),
              onPressed: () {}),
          SizedBox(width: 10)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.settings, color: Hexcolor('03A0B0'), size: 25),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IRremoterSetting(setting)));
        },
      ),
      body: Center(
        child: Container(
          width: 225,
          child: Column(children: <Widget>[
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26),
              child: Image.asset(
                'assets/sender/channel.png',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBtnText('CH-', chm, 'b6142c'),
                buildBtnText('CH', ch, 'b6142c'),
                buildBtnText('CH+', chp, 'b6142c')
              ],
            ),
            buildTextLine("Prev", "Next", "Play"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBtnIcons(prev, 'prev.png', '03a0b0'),
                buildBtnIcons(next, 'next.png', '03a0b0'),
                buildBtnIcons(playpause, 'playpause.png', '006f3c'),
              ],
            ),
            buildTextLine("Vol-", "Vol+", ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBtnIcons(volm, 'volm.png', '264b96'),
                buildBtnIcons(volp, 'volp.png', '264b96'),
                buildBtnText("EQ", eq, 'e77e4e'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBtnText('0', zero, 'ffffff'),
                buildBtnText('100+', onehunp, '03a0b0'),
                buildBtnText('200+', twohunp, '03a0b0')
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBtnText('1', one, 'ffffff'),
                buildBtnText('2', two, 'ffffff'),
                buildBtnText('3', three, 'ffffff')
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBtnText('4', four, 'ffffff'),
                buildBtnText('5', five, 'ffffff'),
                buildBtnText('6', six, 'ffffff')
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildBtnText('7', seven, 'ffffff'),
                buildBtnText('8', edge, 'ffffff'),
                buildBtnText('9', nine, 'ffffff')
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Container buildBtnText(String display, String value, String color) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Hexcolor(color)),
      child: IconButton(
          icon: Text(!isShow ? display : value,
              style: TextStyle(
                  color:
                      color != 'ffffff' ? Colors.white : Hexcolor('161f28'))),
          onPressed: () {
            print(value);
          }),
    );
  }

  Container buildBtnIcons(String value, String path, String color) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Hexcolor(color),
      ),
      child: IconButton(
          icon: !isShow
              ? Padding(
                  padding: EdgeInsets.all(path == 'playpause.png' ? 11.0 : 8.0),
                  child: Image.asset('assets/sender/$path'),
                )
              : Text(value, style: TextStyle(color: Colors.white)),
          onPressed: () {
            print(value);
          }),
    );
  }

  Material buildTextLine(String val1, String val2, String val3) {
    return Material(
        color: Colors.transparent,
        textStyle: TextStyle(
          color: Colors.white,
          fontFamily: 'Quicksand',
          fontSize: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 55, child: Center(child: Text(val1))),
            Container(width: 55, child: Center(child: Text(val2))),
            Container(width: 55, child: Center(child: Text(val3))),
          ],
        ));
  }
}
