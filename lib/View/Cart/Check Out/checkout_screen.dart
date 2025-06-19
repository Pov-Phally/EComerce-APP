import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/Address/address_controller.dart';
import '../../../Controller/Cart/cart_controller.dart';
import '../../../Controller/Payment Methods/payment_controller.dart';
import '../../../Data/Repositories/User/user_repository.dart';
import '../../../Reusable Widget/alert_message.dart';
import '../../../Reusable Widget/cs_checkout_address.dart';
import '../../../Reusable Widget/cs_elevated_button.dart';
import '../../../Reusable Widget/cs_select_method.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = Get.put(AddressController());
    final cartController = Get.find<CartController>();
    final paymentController = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOut', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(() {
                return ListView.separated(
                  separatorBuilder: (_, index) => SizedBox(height: 20),
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (_, index) {
                    final product = cartController.cartItems[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200,
                                    image: DecorationImage(
                                      image: NetworkImage(product.images[0]),
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Color: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: product.selectedColor,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Size: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: product.selectedSize,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Quantity: ',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(
                                            text: product.quantity.toString(),
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  '\$${product.price}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    //Select Address
                    CSSelectMethod(
                      title: 'Address',
                      selectText: 'Select Address',
                      onPressed: () {
                        addressController.selectAddressPopup(context);
                      },
                    ),
                    SizedBox(height: 10),
                    //Address
                    Obx(() {
                      if (addressController
                          .selectedAddress
                          .value
                          .id
                          .isNotEmpty) {
                        return CSCheckOutAddress(
                          selectedAddress:
                              addressController.selectedAddress.value,
                        );
                      } else {
                        return Text('No addresses select');
                      }
                    }),
                    SizedBox(height: 10),
                    Divider(),
                    SizedBox(height: 10),
                    // Total price
                    Obx(() {
                      return Row(
                        children: [
                          Text(
                            'Total: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '\$${cartController.totalPrice}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),

            //Proceed to Payment
            Obx(() {
              return CSElevatedButton(
                text:
                    paymentController.isLoading.value
                        ? 'Proceeding...'
                        : 'Proceed to Payment',
                onPressed: () async {
                  if (addressController.selectedAddress.value.id.isEmpty) {
                    alert(context, 'Please select an address');
                  } else {
                    await paymentController.initPayment(
                      email: UserRepository.instance.authUser!.email!,
                      amount: cartController.totalPrice,
                      context: context,
                    );
                  }
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}