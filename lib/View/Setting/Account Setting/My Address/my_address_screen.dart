import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/Address/address_controller.dart';
import '../../../../Reusable Widget/cs_address_card.dart';
import 'add_new_address_screen.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Obx(() {
            return FutureBuilder(
              key: Key(addressController.refreshData.toString()),
              future: addressController.fetchAllUserAddresses(),
              builder: (_, snapshot) {
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return Center(child: Text(''));
                }
                final address = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.length,
                  itemBuilder: (_, index) {
                    return CSAddressCard(
                      address: address[index],
                      onTap:
                          () => addressController.selectAddress(address[index]),
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNewAddressScreen());
        },
        child: Icon(Icons.add, size: 35),
      ),
    );
  }
}