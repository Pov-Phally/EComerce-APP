import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? get authUser => _auth.currentUser;
  // Save user details to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Fetch user details from Firestore
  Future<UserModel> fetchUserDetails() async {
    final documentSnapshot =
        await _db
            .collection('users')
            .doc(UserRepository.instance.authUser?.uid)
            .get();
    if (documentSnapshot.exists) {
      return UserModel.fromSnapshot(documentSnapshot);
    } else {
      return UserModel.empty();
    }
  }

  // Update user details in Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db
          .collection('users')
          .doc(updateUser.id)
          .update(updateUser.toJson());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Update single field in Firestore
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection('users')
          .doc(UserRepository.instance.authUser?.uid)
          .update(json);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Remove user from Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Upload ImageProfile to Firebase Storage
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Error uploading image';
    }
  }
}