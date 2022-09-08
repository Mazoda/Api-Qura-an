import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static GlobalKey<NavigatorState> navkey = GlobalKey();
  static psuhToWidget(Widget widget) async {
    String? x = await Navigator.of(navkey.currentContext!)
        .push(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }

  static pushWithReplacemnet(Widget widget) {
    Navigator.of(navkey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) {
      return widget;
    }));
  }
}
