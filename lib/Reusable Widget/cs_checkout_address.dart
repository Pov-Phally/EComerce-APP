import 'package:flutter/material.dart';

import '../Model/address_model.dart';

class CSCheckOutAddress extends StatelessWidget {
  const CSCheckOutAddress({super.key, required this.selectedAddress});

  final AddressModel selectedAddress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name: ${selectedAddress.name}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Phone: ${selectedAddress.phoneNumber}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Address: ${selectedAddress.toString()}',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}