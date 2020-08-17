import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/models.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:erobot_app/import/data.dart';

class ArduinoDoc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: docs.length,
        itemBuilder: (context, index) {
          final Doc doc = docs[index];
          return ThreeLayerCard(
            title: doc.title,
            desription: doc.describe,
            cardIndex: doc.index,
            path: 'assets/home/${doc.imagePath}',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DocumentTemplate(doc.index),
                ),
              );
            },
            isCenter: true,
          );
        },
      ),
    );
  }
}
