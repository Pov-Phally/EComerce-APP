import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../Model/product_model.dart';

class WishlistController extends GetxController {
  var wishlist = <ProductModel>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    List? storedWishlistItems = storage.read<List>('wishlistItems');

    if (storedWishlistItems != null) {
      wishlist = storedWishlistItems.map((e) => ProductModel.fromJson(e)).toList().obs;
    }
    ever(wishlist, (_) {
      storage.write('wishlistItems', wishlist.toList());
    });
  }

  void toggleWishlist(ProductModel product) {
    if (wishlist.contains(product)) {
      wishlist.remove(product);
    } else {
      wishlist.add(product);
    }
  }

  bool isWishlist(ProductModel product) {
    return wishlist.contains(product);
  }
}