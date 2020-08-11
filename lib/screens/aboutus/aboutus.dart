import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/screens/aboutus/tabs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:preload_page_view/preload_page_view.dart';

//ABOUT US SCREEN WITH TWO TABS
class AboutUs extends StatelessWidget {
  const AboutUs({
    Key key,
    @required TabController tabController,
    @required this.tabIndex,
    @required PreloadPageController pageController,
  })  : _tabController = tabController,
        _pageController = pageController,
        super(key: key);

  final TabController _tabController;
  final int tabIndex;
  final PreloadPageController _pageController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: Palette.shark,
          //CENTERING APP BAR
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
                kToolbarHeight), //kToolbarHeight HAS SAME CONSTANT THAT AppBar USES.
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Palette.shark,
                    blurRadius: 30.0,
                    spreadRadius: 0.0,
                    offset: Offset(0.0, 0.0),
                    // MOVE TO (RIGHT HORIZONTALLY, BOTTOM VERTICALLY)
                  )
                ],
              ),
              //TAB BAR
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(child: Container()),
                    TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      dragStartBehavior: DragStartBehavior.start,
                      labelStyle: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                      indicatorColor: Colors.white,
                      tabs: <Widget>[
                        Tab(text: 'About Member'),
                        Tab(text: 'Team Reputation')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          //MERGE TAB VIEW WITH PAGE VIEW
          body: NotificationListener(
            child: TabBarView(controller: _tabController, children: [
              AboutMember(),
              TeamReputation(),
            ]),
            onNotification: onNotification,
          ),
        ));
  }

  bool onNotification(overscroll) {
    //IF USER SCROLL UP OR DOWN, DO NOTHING (BUT SCROLL WITH LIST IN TAB)
    if (overscroll is UserScrollNotification &&
        (overscroll.direction == ScrollDirection.forward ||
            overscroll.direction == ScrollDirection.reverse)) {
      print('scrolling');
    } else if (overscroll is OverscrollNotification &&
        overscroll.overscroll != 0 &&
        overscroll.dragDetails != null) {
      print(overscroll.overscroll);

      //IF USER SCROLL DOWN ON TAB[0] => DO NOTHINGS
      if (overscroll.overscroll > 25 && tabIndex == 0) {
        print('Scrolling on tab[0]');
      }
      //IF USER SWAP RIGHT ON TAB[1] => ANIMATE TO PAGE 3 (LOGIN)
      else if (overscroll.overscroll > 20 && tabIndex == 1) {
        print('Swaping on tab[1]');
        _pageController.animateToPage(3,
            curve: Curves.easeOutQuad, duration: Duration(milliseconds: 300));
      }
      //IF USER SWAP LEFT ON TAB[0] => ANIMATE TO PAGE 1 (EDUCATON)
      else if (overscroll.overscroll < -25 && tabIndex == 0) {
        print('Swapping on tab[0]');
        _pageController.animateToPage(1,
            curve: Curves.easeOutQuad, duration: Duration(milliseconds: 300));
      }
    }
    return true;
  }
}
