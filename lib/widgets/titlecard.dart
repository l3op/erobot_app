import 'package:erobot_app/import/importall.dart';

class TitleCard extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const TitleCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(
          kToolbarHeight), //kToolbarHeight has same constant that AppBar uses.
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(18.0, 10.0, 0.0, 10.0),
              child: Container(
                  height: 85,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //EVENT NAME
                        Text(
                          'How to change Name and Password of HC-05',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        SizedBox(height: 5),
                        Author(
                          author: 'Suy Kosal',
                          fontSize: 12,
                        ),
                        SizedBox(height: 5),
                        // DATE
                        Text(
                          '14th May 2020',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
