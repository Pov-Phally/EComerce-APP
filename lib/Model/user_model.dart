import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });
  static UserModel empty() => UserModel(
    id: "",
    username: "",
    email: "",
    phoneNumber: "",
    profilePicture: "",
  );

  // Convert model to JSON structure for storing data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      username: data['Username'] ?? "",
      email: data['Email'] ?? "",
      phoneNumber: data['PhoneNumber'] ?? "",
      profilePicture: data['ProfilePicture'] ?? "",
    );
  }
}