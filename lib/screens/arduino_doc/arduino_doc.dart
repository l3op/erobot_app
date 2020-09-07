import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:erobot_app/import/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ArduinoDoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final Doc doc = docs[index];
            double bottom = 0;
            if (index == docs.length - 1) bottom = 20;
            return Container(
              margin: EdgeInsets.only(bottom: bottom),
              padding: EdgeInsets.fromLTRB(18.0, 10.0, 18, 0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        child: Hero(
                          tag: 'document-image-uniqe-$index',
                          child: Image.asset('./assets/home/${doc.imagePath}',
                              fit: BoxFit.cover),
                        ),
                      ),
                      //EVENT INFO
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doc.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 2),
                          //EVENT ROLE
                          Text(
                            doc.date,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      //READ MORE BUTTON
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            FaIcon(FontAwesomeIcons.child, size: 15),
                            Text(' 25 learnt')
                          ]),
                          Container(
                            height: 28,
                            width: 100,
                            child: FlatButton(
                              splashColor: index == 1
                                  ? Colors.lightBlue
                                  : index == 2
                                      ? Colors.green
                                      : Colors.lightBlueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              color: Palette.shark,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DocumentTemplate(doc.index),
                                  ),
                                );
                              },
                              child: Text(
                                'Read More',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

// ThreeLayerCard(
//             title: doc.title,
//             desription: doc.describe,
//             cardIndex: doc.index,
//             path: 'assets/home/${doc.imagePath}',
//             onPressed: () {
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => DocumentTemplate(doc.index),
//   ),
// );
//             },
//             isCenter: true,
//           );
//         },
