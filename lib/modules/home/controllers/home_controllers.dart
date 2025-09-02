import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeControllerProvider = ChangeNotifierProvider<HomeController>((ref) {
  return HomeController();
});

class HomeController extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  bool showFab = true;

  HomeController() {
    _initScrollListener();
  }

  void _initScrollListener() {
    scrollController.addListener(() {
      final direction = scrollController.position.userScrollDirection;
      if (direction == ScrollDirection.reverse && showFab) {
        showFab = false;
        notifyListeners();
      } else if (direction == ScrollDirection.forward && !showFab) {
        showFab = true;
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
