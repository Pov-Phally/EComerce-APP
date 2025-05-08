import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Controller/Address/address_controller.dart';
import 'package:kh_online_store/Model/address_model.dart';

class CSAddressCard extends StatelessWidget {
  const CSAddressCard({super.key, required this.address,  this.onTap,});

  final AddressModel address;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Obx(() {
      final selectedAddress = addressController.selectedAddress.value.id;
      final isSelected = address.id == selectedAddress;
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.deepPurpleAccent.shade100 : Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          margin: EdgeInsets.only(bottom: 10),
          child: Stack(
            children: [
              Positioned(
                right: 5,
                top: 0,
                bottom: 0,
                child: Icon(
                  isSelected ? FontAwesomeIcons.circleCheck : null, size: 15,),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                  Text(
                    address.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}