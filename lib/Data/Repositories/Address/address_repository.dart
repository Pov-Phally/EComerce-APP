import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../Model/address_model.dart';
import '../User/user_repository.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  Future<List<AddressModel>> fetchUserAddresses() async {
    try {
      final userId = UserRepository.instance.authUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information';
      }

      final result =
          await _db
              .collection('users')
              .doc(userId)
              .collection('Addresses')
              .get();
      return result.docs
          .map((doc) => AddressModel.fromQuerySnapshot(doc))
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Error fetching user addresses';
    }
  }

  Future<void> updateSelectedAddress(String addressId, bool selected) async {
    try {
      final userId = UserRepository.instance.authUser!.uid;
      await _db
          .collection('users')
          .doc(userId)
          .collection('Addresses')
          .doc(addressId)
          .update({'selectAddress': selected});
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
//Store the user address on firebase
  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = UserRepository.instance.authUser!.uid;
      final currentAddress = await _db
          .collection('users')
          .doc(userId)
          .collection('Addresses')
          .add(address.toJson());
      return currentAddress.id;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Error adding address';
    }
  }
}