import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Reusable Widget/alert_message.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();
  final auth = FirebaseAuth.instance;
  final  emailController = TextEditingController();
   GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  // Forgot password
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      // show message
      Get.back();
      alert(Get.context!, 'Email has been sent');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}