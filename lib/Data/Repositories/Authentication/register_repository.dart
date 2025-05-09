import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Model/user_model.dart';
import '../User/user_repository.dart';

class RegisterRepository extends GetxController {
  static RegisterRepository get instance => Get.find();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final userRepository = Get.put(UserRepository());
  final TextEditingController regEmail = TextEditingController();
  final TextEditingController regUsername = TextEditingController();
  final TextEditingController regPhoneNumber = TextEditingController();

  Future<User?> register(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Create a new user model and store it in Firestore
      final newUser = UserModel(
        id: credential.user!.uid,
        email: regEmail.text.trim(),
        username: regUsername.text.trim(),
        phoneNumber: regPhoneNumber.text.trim(),
        profilePicture: '',
      );
      await userRepository.saveUserRecord(newUser);
      return credential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}