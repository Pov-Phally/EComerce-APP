import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kh_online_store/Reusable%20Widget/alert_message.dart';
import 'package:shortid/shortid.dart';

import '../Address/address_controller.dart';
import '../Cart/cart_controller.dart';
import '../../Data/Repositories/Order/order_repository.dart';
import '../../Data/Repositories/User/user_repository.dart';
import '../../Model/order_model.dart';
import '../../View/navigator.dart';

class PaymentController extends GetxController {
  static PaymentController get instance => Get.find();
  final cartController = Get.put(CartController());
  final orderRepository = Get.put(OrderRepository());
  final addressController = Get.put(AddressController());
  var isLoading = false.obs;

  /// Initializes the payment process by creating a payment intent,
  /// initializing the payment sheet, and processing the order if payment is successful.
  Future<void> initPayment({
    required String email,
    required double amount,
    required BuildContext context,
  }) async {
    int amountInCents = (amount * 100).toInt();
    isLoading.value = true;
    try {
      // 1. Create a payment intent on the server
      final response = await http.post(
        Uri.parse('https://stripepaymentintentrequest-nplj4khuea-uc.a.run.app'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'amount': amountInCents}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to create payment intent');
      }

      final jsonResponse = jsonDecode(response.body);
      log(jsonResponse.toString());

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: jsonResponse['paymentIntent'],
          merchantDisplayName: 'Grocery Flutter course',
          customerId: jsonResponse['customer'],
          customerEphemeralKeySecret: jsonResponse['ephemeralKey'],
        ),
      );
      isLoading.value = false;
      await Stripe.instance.presentPaymentSheet();
      // 3. Process the order and clear the cart if payment is successful
      await processOrder(amount);
      clearCart();
    } catch (error) {
      if (error is StripeException) {
        alert(
          Get.context!,
          'An error occurred: ${error.error.localizedMessage}',
        );
        if (kDebugMode) {
          print('Error from Stripe: ${error.error.localizedMessage}');
        }
      } else {
        alert(Get.context!, 'An error occurred: $error');
        if (kDebugMode) {
          print('Error: $error');
        }
      }
    }
  }

  //Processes the order by creating an order model and saving it to Firestore.
  Future<void> processOrder(double totalAmount) async {
    try {
      final userId = UserRepository.instance.authUser!.uid;
      if (userId.isEmpty) return;

      final order = OrderModel(
        id: '',
        orderId: shortid.generate(),
        orderAddress: addressController.selectedAddress.toString(),
        orderDate: DateTime.now(),
        orderStatus: 'Pending',
        totalPrice: totalAmount,
        phoneNumber: addressController.selectedAddress.value.phoneNumber,
        products:
            cartController.cartItems.map((item) {
              return ProductModel(
                name: item.name,
                size: item.selectedSize ?? '',
                color: item.selectedColor ?? '',
                thumbnail: item.thumbnail,
                price: item.price,
                quantity: item.quantity,
              );
            }).toList(),
      );
      // Navigate to the ScreenNavigator screen
      Get.offAll(() => ScreenNavigator());
      alert(Get.context!, 'Order Place Successfully');
      // Save the order to Firestore
      await orderRepository.saveOrder(order, userId);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // Clears the cart by calling the clearCart method from the CartController.
  void clearCart() {
    cartController.clearCart();
  }
}