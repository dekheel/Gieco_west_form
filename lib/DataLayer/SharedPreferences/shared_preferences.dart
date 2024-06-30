import 'dart:convert';

import 'package:gieco_west/DataLayer/Model/my_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static late SharedPreferences sharedPreference;

  static String userData = "userData";

  static init() async {
    sharedPreference = await SharedPreferences.getInstance();
  }

  static Future<bool> saveUserData({required MyUser userDto}) async {
    sharedPreference = await SharedPreferences.getInstance();
    String encodedMap = json.encode(userDto.toFirestore());
    return await sharedPreference.setString(userData, encodedMap);
  }

  static Future<MyUser?> readUserData() async {
    sharedPreference = await SharedPreferences.getInstance();
    String? encodedMap = sharedPreference.getString(userData);
    if (encodedMap == null) return null;
    MyUser? decodedMap = MyUser.fromFirestore(json.decode(encodedMap));
    return decodedMap;
  }

  static Future<bool> removeUser() async {
    sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.remove(userData);
  }
}
