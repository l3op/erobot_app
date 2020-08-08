import 'package:erobot_app/object_class/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveData(Button button) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('top', button.top);
  prefs.setString('left', button.left);
  prefs.setString('bottom', button.bottom);
  prefs.setString('right', button.right);
  prefs.setString('shoot', button.shoot);
  prefs.setString('speed', button.speed);
}

Future<Button> loadData() async {
  String btnTop, btnLeft, btnRight, btnBottom, btnShoot, btnSpeed;
  final prefs = await SharedPreferences.getInstance();

  btnTop = prefs.getString('top') ?? "T";
  btnLeft = prefs.getString('left') ?? "L";
  btnBottom = prefs.getString('bottom') ?? "B";
  btnRight = prefs.getString('right') ?? "R";
  btnShoot = prefs.getString('shoot') ?? "S";
  btnSpeed = prefs.getString('speed') ?? "S";

  Button button =
      Button(btnTop, btnLeft, btnBottom, btnRight, btnShoot, btnSpeed);
  return button;
}
