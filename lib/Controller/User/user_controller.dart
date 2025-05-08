import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kh_online_store/Data/Repositories/User/user_repository.dart';
import 'package:kh_online_store/Reusable%20Widget/alert_message.dart';

import '../../Model/user_model.dart';

class UserController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final profileLoading = true.obs;
  final imageUploading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserDetails();
  }

  //Fecth user details from Firestore
  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
      if (kDebugMode) {
        print(e);
      }
    } finally {
      profileLoading.value = false;
    }
  }

  // Upload profile picture
  uploadProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      if (image != null) {
        imageUploading.value = true;
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile',
          image,
        );

        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageUrl;
        user.refresh();
        //Success message
        alert(Get.context!, 'Profile picture updated');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      imageUploading.value = false;
    }
  }
}