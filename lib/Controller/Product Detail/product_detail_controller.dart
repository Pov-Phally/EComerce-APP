import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  static final productDetailController = ProductDetailController();
  final selectedColor = ''.obs;
  final selectedSize = ''.obs;

  var quantity = 1.obs;

  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}