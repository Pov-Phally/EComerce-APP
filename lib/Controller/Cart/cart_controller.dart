import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Model/product_model.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  var cartItems = <ProductModel>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    List? storedCartItems = storage.read<List>('cartItems');

    if (storedCartItems != null) {
      cartItems =
          storedCartItems.map((e) => ProductModel.fromJson(e)).toList().obs;
    }
    ever(cartItems, (_) {
      storage.write('cartItems', cartItems.toList());
    });
  }

  void addToCart(
    ProductModel product,
    String color,
    String size,
    int quantity,
  ) {
    // Check if the product with the same properties already exists in the cart
    final existingProduct = cartItems.firstWhereOrNull(
      (item) =>
          item.id == product.id &&
          item.selectedColor == color &&
          item.selectedSize == size,
    );
    if (existingProduct != null) {
      // If the product exists, increase the quantity
      existingProduct.quantity += quantity;
    } else {
      // If the product does not exist, create a new instance and add it to the cart
      final newProduct = ProductModel(
        id: product.id,
        name: product.name,
        price: product.price,
        images: product.images,
        description: product.description,
        colors: product.colors,
        sizes: product.sizes,
        selectedColor: color,
        selectedSize: size,
        quantity: quantity,
        thumbnail: product.thumbnail,
        category: '',
        isFeatured: false,
      );
      cartItems.add(newProduct);
    }
    cartItems.refresh();
  }

  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
    cartItems.refresh();
  }

  void incrementQuantity(ProductModel product) {
    product.quantity++;
    cartItems.refresh();
  }

  void decrementQuantity(ProductModel product) {
    if (product.quantity > 1) {
      product.quantity--;
      cartItems.refresh();
    }
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  void clearCart() {
    cartItems.clear();
  }
}