import 'package:flutter/cupertino.dart';

class MyNavigation {
  MyNavigation._();

  static MyNavigation? _myNavigation;

  static MyNavigation getInstance() {
    _myNavigation ??= MyNavigation._();
    return _myNavigation!;
  }

  pushNamed(BuildContext context, String nameRoute) {
    Navigator.pushNamed(context, nameRoute);
  }

  pushReplacementNamed(BuildContext context, String nameRoute) {
    Navigator.pushReplacementNamed(context, nameRoute);
  }
}
