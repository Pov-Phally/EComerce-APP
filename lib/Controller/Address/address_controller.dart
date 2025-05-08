import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_address_card.dart';

import '../../Data/Repositories/Address/address_repository.dart';
import '../../Model/address_model.dart';
import '../../Reusable Widget/cs_elevated_button.dart';
import '../../View/Setting/Account Setting/My Address/add_new_address_screen.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  RxBool refreshData = true.obs;


  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  // Fetch all user addresses
  Future<List<AddressModel>> fetchAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere(
        (element) => element.selectAddress,
        orElse: () => AddressModel.empty(),
      );
      return addresses;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return [];
    }
  }

  // Select an address
  Future selectAddress(AddressModel selectNewAddress) async {
    try {
      //Clear the previous selected address
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedAddress(
          selectedAddress.value.id,
          false,
        );
      }
      //Assign the new selected address
      selectNewAddress.selectAddress = true;
      selectedAddress.value = selectNewAddress;
      // Set the select address to true
      await addressRepository.updateSelectedAddress(
        selectedAddress.value.id,
        true,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Add a new address
  Future<void> saveAddress() async {
    try {
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text,
        postalCode: postalCode.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        country: country.text.trim(),
        selectAddress: true,
      );
      final id = await addressRepository.addAddress(address);
      address.id = id;
      await selectAddress(address);
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Address added successfully')));

      refreshData.toggle();

      resetAddressForm();

      Navigator.of(Get.context!).pop();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
  //
  Future<void> selectAddressPopup(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Address',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              SizedBox(height: 20),
              FutureBuilder<List<AddressModel>>(
                future: fetchAllUserAddresses(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching addresses'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No addresses found'));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return CSAddressCard(
                            address: snapshot.data![index],
                            onTap: () async {
                              await selectAddress(snapshot.data![index]);
                              Get.back();
                            },
                          );
                        },
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              CSElevatedButton(
                text: 'Add New Address',
                onPressed: () {
                  Get.back();
                  Get.to(() => AddNewAddressScreen());
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void resetAddressForm() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState!.reset();
  }
}