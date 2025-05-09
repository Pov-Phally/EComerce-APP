import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Data/Repositories/Authentication/register_repository.dart';
import '../../Data/Repositories/User/user_repository.dart';
import '../../Model/user_model.dart';
import '../../Reusable Widget/alert_message.dart';
import '../../View/Register/email_verification.dart';

class RegisterController extends GetxController {
  final localStorage = GetStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  static RegisterController get instance => Get.find();
  final userRepository = Get.put(UserRepository());
  final registerRepository = Get.put(RegisterRepository());
  final TextEditingController regEmail = TextEditingController();
  final TextEditingController regPassword = TextEditingController();
  final TextEditingController regUsername = TextEditingController();
  final TextEditingController regPhoneNumber = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final isObscure = true.obs;
  final isLoading = false.obs;

  @override
  void dispose() {
    regEmail.dispose();
    regPassword.dispose();
    regUsername.dispose();
    regPhoneNumber.dispose();
    super.dispose();
  }

  Future<void> register() async {
    try {
      isLoading.value = true;
      String username = regUsername.text.trim();
      String email = regEmail.text.trim();
      String phoneNumber = regPhoneNumber.text.trim();
      String password = regPassword.text.trim();
      User? user = await RegisterRepository.instance.register(email, password);

      // check if email already exist
      if (user == null) {
        alert(Get.context!, 'Email already exist');
      }
      // If registration is successful
      if (user != null) {
        // Save user info to Firestore
        final newUser = UserModel(
          id: user.uid,
          username:  username,
          email: email,
          phoneNumber: phoneNumber,
          profilePicture: '', // Default empty profile picture
        );
        await userRepository.saveUserRecord(newUser);
        // Navigate to email verification screen
        Get.off(() => EmailVerificationScreen(email: email.trim()));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Sent Email verification
  Future<void> sendEmailVerification() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}