import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gieco_west/DataLayer/Api/firebase_utils.dart';
import 'package:gieco_west/DataLayer/Provider/user_provider.dart';
import 'package:gieco_west/UiLayer/AuthScreens/LoginScreen/login_screen.dart';
import 'package:gieco_west/UiLayer/HomeScreen/home_screen.dart';
import 'package:provider/provider.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({super.key});
  static String routeName = "authChecker";

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  String? newToken = "";

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    newToken = await FirebaseMessaging.instance.getToken();
  }

  Future<void> updateToken(String userId) async {
    if (newToken != null || newToken != "") {
      await FirebaseUtils.updateToken(userId, newToken);
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data == null) {
              return const LoginPage();
            } else {
              if (newToken != userProvider.currentUser?.token) {
                updateToken(userProvider.currentUser?.id ?? "");
              }
              return const HomeScreen();
            }
          }
        });
  }
}
