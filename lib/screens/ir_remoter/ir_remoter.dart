import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/data/ir_model.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:erobot_app/service/save_preference.dart';

class IrRemoter extends StatefulWidget {
  @override
  _IrRemoterState createState() => _IrRemoterState();
}

class _IrRemoterState extends State<IrRemoter> {
  bool isShow = false;
  List<String> defaultVal = [''];
  List<IRremoteSetting> setting = [];

  @override
  void initState() {
    super.initState();
    _loadCacheData();
  }

  @override
  void dispose() {
    super.dispose();
    _saveCacheData();
  }

  void _saveCacheData() async {
    List<String> values = [];
    for (int i = 0; i < setting.length; i++) values.insert(i, setting[i].value);
    await savetoCacheIRremoterData(values);
  }

  void _loadCacheData() async {
    defaultVal = await loadCacheIRremoterData();
    setState(() {
      for (int i = 0; i < defaultVal.length; i++)
        setting.insert(
            i, IRremoteSetting(btnTitle[i], btnDescribe[i], defaultVal[i]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IR Remoter', style: TextStyle(fontSize: 18)),
        actions: [
          IconButton(
              icon: Icon(
                isShow ? Icons.visibility : Icons.visibility_off,
                color: Colors.white,
              ),
              onPressed: () => setState(() => isShow = !isShow)),
          IconButton(
              icon: Icon(Icons.bluetooth_disabled, color: Colors.white),
              onPressed: () {}),
          SizedBox(width: 10)
        ],
      ),

      //FLOAT SETTING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(Icons.settings, color: Palette.blue_pacific, size: 25),
        onPressed: () async {
          List<IRremoteSetting> setting1 = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => IRremoterSetting(setting)));
          if (setting1 != null)
            setState(() {
              isShow = false;
              setting.replaceRange(0, 21, setting1);
            });
        },
      ),

      //BODY
      body: Center(
        child: Container(
          width: 225,
          child: Column(children: <Widget>[
            SizedBox(height: 25),

            //CHANNEL
            Padding(
              padding: const EdgeInsets.only(left: 26, right: 26),
              child: Image.asset('assets/sender/channel.png'),
            ),
            ThreeCircleButtons(index: 0, isShow: isShow, value: <String>[
                  setting[0].value, // CHANNEL -
                  setting[1].value, // CHANNEL
                  setting[2].value, // CHANNEL +
                ]) ??
                SizedBox(height: 0),

            //PREVIEW + NEXT + PLAY OR PAUSE
            buildTextLine("Prev", "Next", "Play"),
            ThreeCircleButtons(
                  index: 3,
                  isShow: isShow,
                  value: <String>[
                    setting[3].value, // VOL -
                    setting[4].value, // VOL +
                    setting[5].value, // PLAY/PAUSE
                  ],
                ) ??
                SizedBox(height: 0),

            //VOLUMN VOLUMN + EQ
            buildTextLine("Vol-", "Vol+", ''),
            ThreeCircleButtons(
                  index: 6,
                  isShow: isShow,
                  value: <String>[
                    setting[6].value, //
                    setting[7].value, //
                    setting[8].value, //
                  ],
                ) ??
                SizedBox(height: 0),
            SizedBox(height: 10),

            // 0 + 100 + 200
            ThreeCircleButtons(index: 9, isShow: isShow, value: <String>[
                  setting[9].value,
                  setting[10].value,
                  setting[11].value,
                ]) ??
                SizedBox(height: 0),
            SizedBox(height: 10),

            // ONE + TWO + THREE
            ThreeCircleButtons(index: 12, isShow: isShow, value: <String>[
                  setting[12].value,
                  setting[13].value,
                  setting[14].value,
                ]) ??
                SizedBox(height: 0),
            SizedBox(height: 10),

            // FOUR + FIVE + SIX
            ThreeCircleButtons(index: 15, isShow: isShow, value: <String>[
                  setting[15].value,
                  setting[16].value,
                  setting[17].value,
                ]) ??
                SizedBox(height: 0),
            SizedBox(height: 10),

            // SEVEN + EIGHT + NINE
            ThreeCircleButtons(index: 18, isShow: isShow, value: <String>[
                  setting[18].value,
                  setting[19].value,
                  setting[20].value,
                ]) ??
                SizedBox(height: 0)
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
