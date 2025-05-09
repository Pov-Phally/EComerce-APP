import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kh_online_store/Reusable%20Widget/alert_message.dart';
import '../../Data/Repositories/Authentication/log_in_repository.dart';
import '../../View/navigator.dart';

class LogInController extends GetxController {
  final localStorage = GetStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  static LogInController get instance => Get.find();
  final loginRepository = Get.put(LoginRepository());
  final TextEditingController logEmail = TextEditingController();
  final TextEditingController logPassword = TextEditingController();
  final validationError = ''.obs;
  final rememberMe = false.obs;
  final isObscure = true.obs;
  final isLoading = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    if (localStorage.read('Remember_Me_Email') != null) {
      logEmail.text = localStorage.read('Remember_Me_Email');
      logPassword.text = localStorage.read('Remember_Me_Password');
      rememberMe.value = true;
    }
  }

  @override
  void dispose() {
    logEmail.dispose();
    logPassword.dispose();
    super.dispose();
  }

  // Login
  Future<User?> login() async {
    if (rememberMe.value) {
      localStorage.write('Remember_Me_Email', logEmail.text.trim());
      localStorage.write('Remember_Me_Password', logPassword.text.trim());
    }
    try {
      isLoading.value = true;
      String email = logEmail.text.trim();
      String password = logPassword.text.trim();
      final User? user = await loginRepository.login(email, password);
      // check if email and password is correct
      if (user == null) {
        alert(Get.context!, 'Invalid email or password');
      }
      // check if email is verified
      if (!user!.emailVerified) {
        alert(Get.context!, 'Please verify your email address');
      }
      Get.offAll(() => ScreenNavigator());
      alert(Get.context!, 'Login Successful');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  // Log Out
  Future<void> logout() async {
    if (!rememberMe.value) {
      localStorage.remove('Remember_Me_Email');
      localStorage.remove('Remember_Me_Password');
    }
    await auth.signOut();
  }
}