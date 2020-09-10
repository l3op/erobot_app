import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offset = 0; //0 to width size
  double _page = 0; //1 or 0

  PageOffsetNotifier(PreloadPageController pageController) {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      notifyListeners();
    });
  }

  double get offset => _offset;
  double get page => _page;
}
