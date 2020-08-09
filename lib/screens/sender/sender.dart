import 'package:erobot_app/object_class/classes.dart';
import 'package:erobot_app/save_preference/save_preference.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Sender extends StatefulWidget {
  @override
  _SenderState createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  TextEditingController _textController;
  String _valueTMP;
  bool _loaded = false;

  //RECENT TEXT VALUE LIST - THIS WILL BE USED FOR SHARE PREFERENCE
  List<String> _values = [''];

  //RECENT TEXT VALUE + COLOR LIST
  final List<RecentSender> listRecent = <RecentSender>[
    RecentSender('', Colors.transparent)
  ];

  //COLORS FOR RECENT TEXT BUTTON
  var color;
  List<Color> colorsList = [
    Hexcolor('f9a73e'),
    Hexcolor('006f3c'),
    Hexcolor('e77e4e'),
    Hexcolor('b6142c'),
    Hexcolor('03a0b0')
  ];

  @override
  void initState() {
    //LOAD CACHE DATA
    if (!_loaded) _loadData();
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    //SAVE CACHE DATA WHEN POP
    _saveData();
    _textController?.dispose();
    super.dispose();
  }

  //ONLY LOAD ONCE AT FIRST
  _loadData() async {
    _loaded = true;
    _values = await loadRecentSenderData() ?? '';
    for (int i = 1; i < _values.length; i++) {
      color = colorsList[i % 5]; //ONLY 5 COLOR IS USED
      setState(() {
        if (_values[i] != '')
          listRecent.insert(1, RecentSender(_values[i], color));
      });
    }
  }

  //ONLY SAVE ONCE AT CLOSE
  _saveData() async {
    print("saving data");
    saveRecentSenderData(_values) ?? print('data is empty');
  }

  //ON RECENT TEXT BUTTON CLICK
  void onRecentClick(RecentSender recentVal) {
    if (recentVal.recent != '') {
      print("removing " + recentVal.recent);
      setState(() {
        //SET TEXT DATA TO TEXT FIELD
        _textController.text = recentVal.recent;

        //REMOVE TEXT DATA FROM LIST
        _values.remove(recentVal.recent);
        listRecent.remove(recentVal);
      });
    } else {
      //IF CLICK ON '' EMPTY => NOT REMOVE IT (IT'S USED TO MAKE SPACE)
      print('empty value cant be removed');
    }
  }

  //ADD TEXT DATA TO LIST
  void addtoRecent() {
    print("adding data to recently");
    color = colorsList[listRecent.length % 5];

    //TRIM TO REMOVE SPACE AT BEGIN AND END
    _valueTMP = _valueTMP.trim();
    print(_valueTMP);

    if (_values.length > 10) {
      //ONLY STORE 10 VALUE IN LIST
      //IF VALUE > 10 REMOVE THE LAST VALUE

      _values.removeAt(1);
      //REMOVE AT INDEX[1] BECAUSE WE ADD AT LAST INDEX
      //WHEN ADD: values[1, 2, 3, .., (add value here[LAST INDEX])]
      //SO REMOVE AT INDEX[1] CAUSE IT IS FIRST ADDED VALUE

      listRecent.removeAt(10);
      //REMOVE AT INDEX[10] BECAUSE WE ADD AT INDEX[1]
      //WHEN ADD: value[(add value here), 2, 3, ....]
      //SO REMOVE AT 10 WHICH IS FIRST ADDED VALUE
    }
    if (_valueTMP != '') {
      for (int i = 0; i < listRecent.length; i++) {
        if (_valueTMP == listRecent[i].recent) {
          //IF listRecent HAVE DUBLICATE VALUE => REMOVE OLD VALUE
          listRecent.removeAt(i);
          _values.remove(_valueTMP);
        }
      }

      if (_values.contains(_valueTMP)) {
        //(DUBLICATE VALUE) AFTER REMOVE AT OLD VALUE, ADD TO FRONT
        setState(() {
          _values.insert(_values.length, _valueTMP);
          listRecent.insert(1, RecentSender(_valueTMP, color));
        });
        print('remove and add in if contain');
      } else if (!_values.contains(_valueTMP)) {
        //ELSE INSERT VALUE TO LIST
        setState(() {
          listRecent.insert(1, RecentSender(_valueTMP, color));
          _values.insert(_values.length, _valueTMP);
        });
        print('remove and add in if not contain');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sender', style: TextStyle(fontSize: 18)),
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Hexcolor('c4c4c4'),
                    borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.only(bottom: 0),
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          //BUTTON TO CLEAR TEXT FIELD VALUE
                          icon: Icon(Icons.clear, size: 20),
                          onPressed: () {
                            setState(() {
                              _textController.clear();
                            });
                          }),
                      border: InputBorder.none,
                      labelText: "Type anything here...",
                      labelStyle:
                          TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 20, 0)),
                  keyboardType: TextInputType.text,
                  onChanged: (_value) {
                    _valueTMP = _value;
                  },
                ),
              ),
              SizedBox(height: 5),

              //SEND TO BLUETOOTH BUTTON & SAVE DATA TO LIST
              FlatButton(
                child: Text('Send',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                color: Hexcolor('03a0B0'),
                onPressed: () {
                  if (_valueTMP != null) {
                    print(listRecent.length.toString());
                    addtoRecent();
                  }
                },
              ),
              Divider(color: Hexcolor('c4c4c4')),
              Text(listRecent.length > 1 ? 'Recently' : 'No recent data',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ],
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 37,
          //BUILDER LIST OF RECENT TEXT VALUE
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listRecent.length,
              itemBuilder: (context, index) {
                RecentSender recentVal = listRecent[index];
                return recentVal.recent != null
                    ? Row(
                        children: [
                          //RECENT TEXT THAT CLICKABLE
                          GestureDetector(
                            onTap: () {
                              onRecentClick(recentVal);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: recentVal.color,
                                ),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 17),
                                  child: Text(
                                    recentVal.recent,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      )
                    : Text('');
              }),
        )
      ]),
    );
  }
}
