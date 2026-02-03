import 'package:flutter/material.dart';

import '../framework/navigation_animation.dart';

extension NavigationHelper on BuildContext {
  Future push(Widget page) {
    return Navigator.of(this).push(
      FadePageRoute(builder: (context) => page),
    );
  }

  Future<Object?> pushWithNamed(String pageRoute, {Object? arguments}) {
    return Navigator.of(this).pushNamed(
      pageRoute,
      arguments: arguments,
    );
  }

  void pushReplacement(Widget page) {
    Navigator.of(this).pushReplacement(
      FadePageRoute(builder: (context) => page),
    );
  }

  void pushReplacementWithNamed(String pageRoute, {Object? arguments}) {
    Navigator.of(this).pushReplacementNamed(
      pageRoute,
      arguments: arguments,
    );
  }

  void pushAndRemoveUntil(Widget page) {
    Navigator.of(this).pushAndRemoveUntil(
      FadePageRoute(builder: (context) => page),
          (route) => false,
    );
  }

  void pushAndRemoveUntilWithNamed(String pageRoute, {Object? arguments}) {
    Navigator.of(this).pushNamedAndRemoveUntil(
      pageRoute,
          (route) => false,
      arguments: arguments,
    );
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
