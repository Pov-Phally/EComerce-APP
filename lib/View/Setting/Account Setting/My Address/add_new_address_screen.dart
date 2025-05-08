import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_elevated_button.dart';

import '../../../../Controller/Address/address_controller.dart';
import '../../../../Reusable Widget/cs_text_form_field.dart';

class AddNewAddressScreen extends StatelessWidget {
  const AddNewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: addressController.addressFormKey,
            child: Column(
              children: [
                SizedBox(height: 15),
                //Name
                CSTextFormField(
                  label: 'Name',
                  prefixIcon: Icon(Icons.person),
                  controller: addressController.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                //Phone number
                CSTextFormField(
                  label: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  controller: addressController.phoneNumber,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    //Street
                    Expanded(
                      child: CSTextFormField(
                        label: 'Street',
                        prefixIcon: Icon(FontAwesomeIcons.building),
                        controller: addressController.street,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your street';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    //Postal code
                    Expanded(
                      child: CSTextFormField(
                        label: 'Postal Code',
                        prefixIcon: Icon(Icons.code_off_rounded),
                        controller: addressController.postalCode,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your postal code';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    //City
                    Expanded(
                      child: CSTextFormField(
                        label: 'City',
                        prefixIcon: Icon(FontAwesomeIcons.city),
                        controller: addressController.city,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your city';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    //State
                    Expanded(
                      child: CSTextFormField(
                        label: 'State',
                        prefixIcon: Icon(Icons.qr_code_sharp),
                        controller: addressController.state,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your state';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                //Country
                CSTextFormField(
                  label: 'Country',
                  prefixIcon: Icon(FontAwesomeIcons.globe),
                  controller: addressController.country,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                //Save
                CSElevatedButton(
                  text: 'Save',
                  onPressed: () {
                    if (addressController.addressFormKey.currentState!.validate()) {
                      addressController.saveAddress();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}