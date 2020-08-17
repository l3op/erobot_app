import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';

class LogInChoice extends StatefulWidget {
  @override
  _LogInChoiceState createState() => _LogInChoiceState();
}

class _LogInChoiceState extends State<LogInChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 2, top: 10, bottom: 3),
              child: Text(
                'WELCOME OUR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            TwoLayerCard(),
            SizedBox(height: 10),
            Text(
              'Member will have access all privilege to see post, oportunity, and team reputation',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            FlatTextButton(
              isblue: true,
              text: 'Login as member',
              splashColor: Palette.blueSplash,
              color: Palette.blue_pacific,
              onPressed: () => Navigator.pushNamed(context, '/loginP'),
            ),
            SizedBox(height: 10),
            FlatTextButton(
              text: 'Join Us',
              onPressed: () => Navigator.pushNamed(context, '/joinus'),
            ),
          ],
        ),
      ),
    );
  }
}
