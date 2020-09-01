import 'package:erobot_app/import/importall.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';

//123@Erobot
class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    print('init user: ' + user.toString());
    if (user == null)
      return LogInChoice();
    else
      return UserProfileSetting();
  }
}

class UserProfileSetting extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
        Text(''),
        RaisedButton(
          child: Text('Sign out'),
          onPressed: () {
            _auth.signOut();
          },
        )
      ],
    );
  }
}
