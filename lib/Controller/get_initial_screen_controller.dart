import 'package:firebase_auth/firebase_auth.dart';
import 'package:kh_online_store/View/LogIn/log_in_screen.dart';
import 'package:kh_online_store/View/navigator.dart';
import 'package:flutter/widgets.dart';

class GetInitialScreenController {
  Widget getInitialScreen() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      return ScreenNavigator();
    } else {
      return LogInScreen();
    }
  }
}