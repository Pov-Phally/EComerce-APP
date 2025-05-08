import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Controller/Authentication/register_controller.dart';
import 'package:kh_online_store/Reusable%20Widget/alert_message.dart';

import '../../View/Register/successfully_verification_screen.dart';

class EmailVerificationController extends GetxController {
  static EmailVerificationController get instance => Get.find();
  final auth = Get.put(RegisterController());
  var isEmailVerified = false.obs;

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  Future<void> sendEmailVerification() async {
    try {
      await auth.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {}
    }
  }

  // set timer for auto redirect
  setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      isEmailVerified.value = user?.emailVerified ?? false;
      if (isEmailVerified.value) {
        timer.cancel();
        Get.offAll(() => SuccessfullyVerificationScreen());
        // show message
        alert(Get.context!, 'Registration successful');
      }
    });
  }

  //Manually check email verify
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.offAll(() => SuccessfullyVerificationScreen());
      // show message
      alert(Get.context!, 'Registration successful');
    }
  }
}