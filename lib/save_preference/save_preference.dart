import 'package:erobot_app/object_class/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData(Button button, int index) async {
  final prefs = await SharedPreferences.getInstance();
  if (index == 1) {
    prefs.setString('top', button.top);
    prefs.setString('left', button.left);
    prefs.setString('bottom', button.bottom);
    prefs.setString('right', button.right);
    prefs.setString('shoot', button.power);
  } else {
    prefs.setString('top1', button.top);
    prefs.setString('left1', button.left);
    prefs.setString('bottom1', button.bottom);
    prefs.setString('right1', button.right);
    prefs.setString('speed', button.power);
  }
}

Future<Button> loadData(int index) async {
  String btnTop, btnLeft, btnRight, btnBottom, btnPower;
  final prefs = await SharedPreferences.getInstance();

  //INDEX = 1 IS BALL SHOOTER , ELSE CAR RUNNER
  if (index == 1) {
    btnTop = prefs.getString('top') ?? "T";
    btnLeft = prefs.getString('left') ?? "L";
    btnBottom = prefs.getString('bottom') ?? "B";
    btnRight = prefs.getString('right') ?? "R";
    btnPower = prefs.getString('shoot') ?? "S";
  } else {
    btnTop = prefs.getString('top1') ?? "T";
    btnLeft = prefs.getString('left1') ?? "L";
    btnBottom = prefs.getString('bottom1') ?? "B";
    btnRight = prefs.getString('right1') ?? "R";
    btnPower = prefs.getString('speed') ?? "P";
  }

  Button button =
      Button(btnTop, btnLeft, btnBottom, btnRight, btnPower);
  return button;
}
