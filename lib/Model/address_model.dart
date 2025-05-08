import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String id;
  String name;
  String phoneNumber;
  String street;
  String postalCode;
  String city;
  String state;
  String country;
  bool selectAddress;


  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.postalCode,
    required this.city,
    required this.state,
    required this.country,
    this.selectAddress = true,
  });

  // Factory method to create an empty AddressModel.
  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    postalCode: '',
    city: '',
    state: '',
    country: '',
  );

  // Method to convert the AddressModel to a JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'street': street,
      'postalCode': postalCode,
      'city': city,
      'state': state,
      'country': country,
      'selectAddress': selectAddress,
    };
  }

  // Factory method to create an AddressModel from a Firebase document snapshot.
  factory AddressModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data() as Map<String, dynamic>;

    return AddressModel(
      id: document.id,
      name: data['name'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      street: data['street'] ?? '',
      postalCode: data['postalCode'] ?? '',
      city: data['city'] ?? '',
      state: data['state'] ?? '',
      country: data['country'] ?? '',
      selectAddress: data['selectAddress'] as bool,
    );
  }
  // Factory method to create an AddressModel from a JSON map.
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      street: json['street'] ?? '',
      postalCode: json['postalCode'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      selectAddress: json['selectAddress'] as bool,
    );
  }
  // Method to format the address for display.
  @override
  String toString() {
    return '$street, $city, $state, $postalCode,$country';
  }
}