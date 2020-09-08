import 'package:erobot_app/config/offset_notifier.dart';
import 'package:erobot_app/widgets/bottom_navigation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:erobot_app/config/palette.dart';
import 'package:erobot_app/import/widgets.dart';
import 'package:erobot_app/import/screens.dart';
import 'package:provider/provider.dart';

//ROOT PAGE
class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> with SingleTickerProviderStateMixin {
  int pageIndex = 0;
  int tabIndex = 0;
  bool userPageDragging = false;

  //CONTROLLER
  PreloadPageController _pageController;
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    _pageController = PreloadPageController(
      initialPage: pageIndex,
      keepPage: true,
      viewportFraction: 1,
    );

    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: tabIndex,
    );

    _scrollViewController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  final List<String> titleName = [
    'E-Robot',
    'Education',
    'About Us',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    //ROOT PAGE
    return ScrollConfiguration(
      //ScrollConfiguration IS USED TO HIDE SCROLL EFFECT (WHITE EFFECT)
      behavior: ScrollBehavior()
        ..buildViewportChrome(context, null, AxisDirection.down),
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: ChangeNotifierProvider(
          create: (e) => PageOffsetNotifier(_pageController),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: buildAppBar(),
            drawer: MainDrawer(),
            body: Container(
              //PRELOAD : TO ENSURE PAGES ARE LOADED BEFORE USABLE
              child: PreloadPageView(
                children: <Widget>[
                  HomeScreen(),
                  ArduinoDoc(),
                  AboutUs(
                    tabController: _tabController,
                    tabIndex: tabIndex,
                  ),
                  Profile()
                ],
                physics: const ClampingScrollPhysics(),
                preloadPagesCount: 4,
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => pageIndex = index);
                },
              ),
            ),
            //BOTTOM NAVIGATION
            bottomNavigationBar: AnimatedBottomNavigation(
              currentPage: pageIndex,
              onTab: (index) => onBottomTab(index),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: pageIndex == 2 ? 0 : 5,
      leading: Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Builder(
          builder: (context) => IconButton(
            icon: FaIcon(
              FontAwesomeIcons.alignLeft,
              size: 20,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      title: Consumer<PageOffsetNotifier>(
        builder: (context, notifier, child) {
          return Opacity(
            opacity: (1 - notifier.page % 1) / 2 >= 0.25
                ? 1 - notifier.page % 1
                : notifier.page % 1,
            child: child,
          );
        },
        child: Row(
          children: [
            Text(
              titleName[pageIndex],
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }

  //HUDDLE BACK PRESSED
  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Color(0xFF161F28),
            title: Text(
              'Are you sure?',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            content: Text(
              'Do you want to exit an App',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () => Navigator.of(context).pop(false),
                child: DialogBtn('No'),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: DialogBtn('Yes'),
              ),
              SizedBox(width: 10)
            ],
          ),
        ) ??
        false;
  }

  void onBottomTab(_index) async {
    var duration = 400;
    //FROM PAGE[0] TO PAGE[3] => ANIMATE TO PAGE[2] THEN PAGE[3]
    if (_index == 3 && pageIndex == 0) {
      _pageController.jumpToPage(2);
      _pageController.animateToPage(
        3,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: duration + 50),
      );
    }
    //FROM PAGE[3] TO PAGE[0] => ANIMATE TO PAGE[1] THEN PAGE[0]
    if (_index == 0 && pageIndex == 3) {
      _pageController.jumpToPage(1);
      _pageController.animateToPage(
        0,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: duration + 50),
      );
    }
    //FROM PAGE THAT INDEX -= 2 => ANIMATE TO MIDDLE PAGE THEN DESTINATION
    if ((_index - pageIndex) == 2 || (pageIndex - _index) == 2) {
      int _indexR; //Destination
      if (_index > pageIndex) //Check which is destination
        _indexR = pageIndex;
      else
        _indexR = _index;
      _pageController.jumpToPage(_indexR + 1);
      _pageController.animateToPage(
        _index,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: duration - 50),
      ); //+100
    }
    //FROM PAGE THAT INDEX -= 1 => ANIMATE TO PAGE DIRECTLY
    else {
      _pageController.animateToPage(
        _index,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: duration - 100),
      );
    }
  }
}
