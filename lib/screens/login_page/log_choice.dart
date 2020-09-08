import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:provider/provider.dart';

class LogInChoice extends StatefulWidget {
  @override
  _LogInChoiceState createState() => _LogInChoiceState();
}

class _LogInChoiceState extends State<LogInChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          double offset =
              MediaQuery.of(context).size.width * 3 - notifier.offset;
          double opacity = notifier.page < 3
              ? notifier.page % 1
              : 1 - notifier.page % 1;
          return Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Transform.translate(
                  offset: Offset(offset * 0.6, 0),
                  child: Opacity(
                    opacity: opacity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 2, top: 10, bottom: 3),
                      child: Text(
                        'WELCOME OUR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(offset * 0.9, 0),
                  child: Opacity(opacity: opacity, child: TwoLayerCard()),
                ),
                SizedBox(height: 10),
                Transform.translate(
                  offset: Offset(offset * 1.2, 0),
                  child: Opacity(
                    opacity: opacity,
                    child: Text(
                      'Member will have access all privilege to see post, oportunity, and team reputation',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Transform.translate(
                  offset: Offset(offset * 1.5, 0),
                  child: Opacity(
                    opacity: opacity,
                    child: FlatTextButton(
                      isblue: true,
                      text: 'Login as member',
                      splashColor: Palette.blueSplash,
                      color: Palette.blue_pacific,
                      onPressed: () => Navigator.pushNamed(context, '/loginP'),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Transform.translate(
                  offset: Offset(offset * 1.8, 0),
                  child: Opacity(
                    opacity: opacity,
                    child: FlatTextButton(
                      text: 'Join Us',
                      onPressed: () => Navigator.pushNamed(context, '/joinus'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
