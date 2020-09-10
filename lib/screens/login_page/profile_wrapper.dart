import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/import/importall.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import 'dart:math' as math;

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

class UserProfileSetting extends StatefulWidget {
  @override
  _UserProfileSettingState createState() => _UserProfileSettingState();
}

class _UserProfileSettingState extends State<UserProfileSetting>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height),
          child: Wrap(
            children: [
              Container(
                height: 225,
                width: MediaQuery.of(context).size.width,
                color: Palette.bigstone,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Palette.blue_pacific, width: 5.0),
                        borderRadius: BorderRadius.circular(60 + 5.0),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage('assets/profiles/bot2.png'),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'user@erobot.kh',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                color: Palette.blue_pacific,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: 'Your Profile'),
                    Tab(text: 'Activities'),
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            Container(
              child: ListView(
                children: [
                  UserSettingTile(
                      onPressed: () {},
                      index: 0,
                      title: "Email",
                      subtitle: "user@erobot.kh",
                      icon: FontAwesomeIcons.envelope),
                  UserSettingTile(
                      onPressed: () {},
                      index: 1,
                      title: "Phone",
                      subtitle: "012 3456 78",
                      icon: FontAwesomeIcons.phoneAlt),
                  UserSettingTile(
                      onPressed: () {},
                      index: 2,
                      title: "Password",
                      subtitle: lengthToX(6),
                      icon: FontAwesomeIcons.lock),
                ],
              ),
            ),
            Consumer<PageOffsetNotifier>(
              builder: (context, notifier, child) {
                double offset =
                    MediaQuery.of(context).size.width * 3 - notifier.offset;
                return Transform.translate(
                    offset: Offset(offset * 0.4, 0),
                    child: Opacity(
                        opacity: notifier.page > 3
                            ? math.max(0, -notifier.page % 1)
                            : notifier.page != 3
                                ? math.max(0, notifier.page % 1)
                                : 1,
                        child: child));
              },
              child: Container(
                color: Palette.red_milano,
                child: Center(
                  child: Text(
                    "In construction",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String lengthToX(int length) {
    String xxx = "";
    for (int i = 0; i < 8; i++) xxx += "*";
    return xxx ?? "No Password";
  }
}

class UserSettingTile extends StatelessWidget {
  final String subtitle, title;
  final IconData icon;
  final Function onPressed;
  final int index;

  const UserSettingTile({
    Key key,
    @required this.subtitle,
    @required this.title,
    @required this.icon,
    @required this.onPressed,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double offset = MediaQuery.of(context).size.width * 3 - notifier.offset;
        return Transform.translate(
          offset: Offset(offset * index * 0.4, 0),
          child: Opacity(
              opacity: notifier.page > 3
                  ? math.max(0, -notifier.page % 1)
                  : notifier.page != 3 ? math.max(0, notifier.page % 1) : 1,
              child: child),
        );
      },
      child: ListTile(
        leading: FaIcon(
          icon,
          color: Palette.blue_pacific,
          size: 36,
        ),
        title: Text(
          title,
          style: TextStyle(color: Palette.blue_pacific),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Quicksand",
          ),
        ),
      ),
    );
  }
}
