import 'package:flutter/material.dart';
import 'package:gieco_west/DataLayer/Model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  UserProvider({required MyUser? newUser}) {
    if (newUser != null) {
      currentUser = newUser;
      notifyListeners();
    }
  }

  void updateUser({MyUser? newUser}) {
    if (newUser != null) {
      currentUser = newUser;
      notifyListeners();
    }
  }
}
