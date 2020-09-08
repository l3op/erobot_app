import 'package:erobot_app/config/palette.dart';
import 'package:flutter/material.dart';

class BarItem {
  String item;
  IconData icon;
  BarItem({this.item, this.icon});
}

class AnimatedBottomNavigation extends StatefulWidget {
  final List<BarItem> barItem = [
    BarItem(item: 'Home', icon: Icons.home),
    BarItem(item: 'Education', icon: Icons.school),
    BarItem(item: 'About us', icon: Icons.people),
    BarItem(item: 'Profile', icon: Icons.person),
  ];
  final int currentPage;
  final Function onTab;

  AnimatedBottomNavigation(
      {Key key, @required this.onTab, @required this.currentPage})
      : super(key: key);

  @override
  _AnimatedBottomNavigationState createState() =>
      _AnimatedBottomNavigationState();
}

class _AnimatedBottomNavigationState extends State<AnimatedBottomNavigation> {
  int selectedBar = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Palette.bigstone,
      child: AnimatedBottomBar(
          barItems: widget.barItem,
          currentIndex: widget.currentPage,
          animationDuration: const Duration(milliseconds: 1000),
          onTab: (index) {
            setState(() {
              selectedBar = index;
            });
            widget.onTab(index);
          }),
    );
  }
}

class AnimatedBottomBar extends StatefulWidget {
  final List<BarItem> barItems;
  final Duration animationDuration;
  final Function onTab;
  final int currentIndex;

  const AnimatedBottomBar({
    Key key,
    this.barItems,
    this.animationDuration = const Duration(milliseconds: 1000),
    @required this.onTab,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = widget.currentIndex;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _buildBarItem(_selectedIndex),
    );
  }

  List<Widget> _buildBarItem(int _selectedIndex) {
    List<Widget> _barItem = List();
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = _selectedIndex == i;
      _barItem.add(
        InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = i;
            });
            widget.onTab(_selectedIndex);
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  item.icon,
                  size: 30,
                  color: isSelected ? Palette.bigstone : Colors.white,
                ),
                SizedBox(width: 8.0),
                AnimatedSize(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                  vsync: this,
                  child: Text(
                    isSelected ? item.item : "",
                    style: TextStyle(
                      color: isSelected ? Palette.bigstone : Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return _barItem;
  }
}
