import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/screens.dart';

class IrRemoter extends StatefulWidget {
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
    chm = '0xFFA25D';
    chp = '0xFFE21D';
    ch = '0xFF629D';
    prev = '0xFF22DD';
    next = '0xFF02FD';
    playpause = '0xFFC23D';
    volm = '0xFFE01F';
    volp = '0xFFA857';
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
      IRremoteSetting('EQ', 'EQ', eq),
      IRremoteSetting('100+', 'Increase 100', onehunp),
      IRremoteSetting('200+', 'Increase 200', twohunp),
      IRremoteSetting('1', 'Number 1', one),
      IRremoteSetting('2', 'Number 2', two),
      IRremoteSetting('3', 'Number 3', three),
      IRremoteSetting('4', 'Number 4', four),
      IRremoteSetting('5', 'Number 5', five),
      IRremoteSetting('6', 'Number 6', six),
      IRremoteSetting('7', 'Number 7', seven),
      IRremoteSetting('8', 'Number 8', edge),
      IRremoteSetting('9', 'Number 9', nine),
      IRremoteSetting('0', 'Number 0', zero),
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
        child: Icon(Icons.settings, color: Palette.blue_pacific, size: 25),
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
                CircleButtonText(
                    onPressed: () => print(chm),
                    isShow: isShow,
                    display: 'CH-',
                    value: chm,
                    color: 'b6142c'),
                CircleButtonText(
                    onPressed: () => print(ch),
                    isShow: isShow,
                    display: 'CH',
                    value: ch,
                    color: 'b6142c'),
                CircleButtonText(
                    onPressed: () => print(chp),
                    isShow: isShow,
                    display: 'CH+',
                    value: chp,
                    color: 'b6142c')
              ],
            ),
            buildTextLine("Prev", "Next", "Play"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonIcon(
                    onPressed: () => print(prev),
                    isShow: isShow,
                    value: prev,
                    path: 'prev.png',
                    color: '03a0b0'),
                CircleButtonIcon(
                    onPressed: () => print(next),
                    isShow: isShow,
                    value: next,
                    path: 'next.png',
                    color: '03a0b0'),
                CircleButtonIcon(
                    onPressed: () => print(playpause),
                    isShow: isShow,
                    value: playpause,
                    path: 'playpause.png',
                    color: '006f3c'),
              ],
            ),
            buildTextLine("Vol-", "Vol+", ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonIcon(
                    onPressed: () => print(volm),
                    isShow: isShow,
                    value: volm,
                    path: 'volm.png',
                    color: '264b96'),
                CircleButtonIcon(
                    onPressed: () => print(volp),
                    isShow: isShow,
                    value: volp,
                    path: 'volp.png',
                    color: '264b96'),
                CircleButtonText(
                    onPressed: () => print(eq),
                    isShow: isShow,
                    display: "EQ",
                    value: eq,
                    color: 'e77e4e'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonText(
                    onPressed: () => print(zero),
                    isShow: isShow,
                    display: '0',
                    value: zero,
                    color: 'ffffff'),
                CircleButtonText(
                    onPressed: () => print(onehunp),
                    isShow: isShow,
                    display: '100+',
                    value: onehunp,
                    color: '03a0b0'),
                CircleButtonText(
                    onPressed: () => print(twohunp),
                    isShow: isShow,
                    display: '200+',
                    value: twohunp,
                    color: '03a0b0')
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonText(
                    onPressed: () => print(one),
                    isShow: isShow,
                    display: '1',
                    value: one,
                    color: 'ffffff'),
                CircleButtonText(
                    onPressed: () => print(two),
                    isShow: isShow,
                    display: '2',
                    value: two,
                    color: 'ffffff'),
                CircleButtonText(
                    onPressed: () => print(three),
                    isShow: isShow,
                    display: '3',
                    value: three,
                    color: 'ffffff')
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonText(
                    onPressed: () => print(four),
                    isShow: isShow,
                    display: '4',
                    value: four,
                    color: 'ffffff'),
                CircleButtonText(
                    onPressed: () => print(five),
                    isShow: isShow,
                    display: '5',
                    value: five,
                    color: 'ffffff'),
                CircleButtonText(
                    onPressed: () => print(six),
                    isShow: isShow,
                    display: '6',
                    value: six,
                    color: 'ffffff')
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleButtonText(
                    onPressed: () => print(seven),
                    isShow: isShow,
                    display: '7',
                    value: seven,
                    color: 'ffffff'),
                CircleButtonText(
                    onPressed: () => print(edge),
                    isShow: isShow,
                    display: '8',
                    value: edge,
                    color: 'ffffff'),
                CircleButtonText(
                    onPressed: () => print(nine),
                    isShow: isShow,
                    display: '9',
                    value: nine,
                    color: 'ffffff')
              ],
            ),
          ]),
        ),
      ),
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

