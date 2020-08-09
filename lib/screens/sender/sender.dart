import 'package:erobot_app/object_class/classes.dart';
//import 'package:erobot_app/save_preference/save_preference.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Sender extends StatefulWidget {
  Sender({Key key}) : super(key: key);

  @override
  _SenderState createState() => _SenderState();
}

class _SenderState extends State<Sender> {
  final _formKey = GlobalKey<FormState>();
  String valueTMP;

  var color;
  List<Color> colorsList = [
    Hexcolor('f9a73e'),
    Hexcolor('006f3c'),
    Hexcolor('e77e4e'),
    Hexcolor('b6142c'),
    Hexcolor('03a0b0')
  ];

  List<String> values = [''];
  @override
  void initState() {
    super.initState();
    //_loadData();
  }

  // _loadData() async {
  //   values = await loadRecentSenderData();
  //   for (int i = 0; i < values.length; i++) {
  //     if (values[i] != null) {
  //       listRecent.insert(0, RecentSender(values[i], Colors.red));
  //     }
  //   }
  // }

  final List<RecentSender> listRecent = <RecentSender>[
    RecentSender('', Colors.transparent),
  ];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sender', style: TextStyle(fontSize: 18)),
      ),
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Hexcolor('c4c4c4'),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: "Type anything here...",
                        labelStyle:
                            TextStyle(color: Color.fromRGBO(0, 0, 0, 0.6)),
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 20, 0)),
                    keyboardType: TextInputType.text,
                    onChanged: (value) {
                      valueTMP = value;
                    },
                  ),
                ),
                SizedBox(height: 5),
                FlatButton(
                  child: Text('Send',
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: Hexcolor('03a0B0'),
                  onPressed: addtoRecent,
                ),
                Divider(
                  color: Hexcolor('c4c4c4'),
                ),
                Text(
                  listRecent.length > 2 ? 'Recently' : 'No recent data',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          Container(
            height: 37,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: listRecent.length,
                itemBuilder: (context, index) {
                  RecentSender recentVal = listRecent[index];
                  return recentVal.recent != null
                      ? Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                removeOnClick(recentVal);
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
                      : null;
                }),
          )
        ]),
      ),
    );
  }

  void removeOnClick(RecentSender removeValue) {
    print(removeValue.recent);
    values.remove(removeValue.recent);
    setState(() {
      listRecent.remove(removeValue);
    });
  }

  void addtoRecent() {
    print("valuelength: " + values.length.toString());
    if (values.length > 10) {
      values.removeAt(1);
      listRecent.removeAt(10);
    }
    if (values.contains(valueTMP)) {
      values.remove(valueTMP);
      for (int i = 0; i < listRecent.length; i++) {
        ////DO THERE
      }
      setState(() {
        listRecent.remove(listRecent);
      });
    }
    if (!values.contains(valueTMP) && valueTMP != '') {
      values.insert(values.length, valueTMP);
      color = colorsList[values.length % 5];
      setState(() {
        listRecent.insert(1, RecentSender(valueTMP, color));
      });
    }
    print("result: ");
    for (String i in values) print(i);
  }
}
