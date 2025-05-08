import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Data/Repositories/User/user_repository.dart';
import '../../Reusable Widget/alert_message.dart';
import '../User/user_controller.dart';

class UpdateController extends GetxController {
  static UpdateController get instance => Get.find();
  final userName = TextEditingController();
  GlobalKey updateUsernameFormKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    initializeName();
  }

  Future<void> initializeName() async {
    userName.text = userController.user.value.username;
  }

  //Update Username
  Future<void> updateUsername() async {
    try {
      Map<String, dynamic> name = {'Username': userName.text.trim()};
      await userRepository.updateSingleField(name);
      userController.user.value.username = userName.text.trim();
      Get.back();
        alert(Get.context!, 'Username Updated Successfully');
      userController.user.refresh();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}