import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kh_online_store/Controller/Wishlist/wishlist_controller.dart';
import 'package:kh_online_store/Controller/get_initial_screen_controller.dart';
import 'package:kh_online_store/stripe_service.dart';
import 'Controller/Cart/cart_controller.dart';
import 'FireBase/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  Stripe.publishableKey = StripeService().stripePublishableKey;
  await Stripe.instance.applySettings();
  Get.put(CartController());
  Get.put(WishlistController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.openSansTextTheme()),
      debugShowCheckedModeBanner: false,
      home: GetInitialScreenController().getInitialScreen(),
    );
  }
}