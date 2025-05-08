import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store_admin/View/navigator.dart';
import 'Controller/add_product_controller.dart';
import 'FireBase/firebase_notification.dart';
import 'FireBase/firebase_options.dart';
import 'LocalNotificationService/local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.initializeFCM();
  await LocalNotificationService.initializeLocalNotifications();
  Get.put(AddProductController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: NavigatorScreen());
  }
}