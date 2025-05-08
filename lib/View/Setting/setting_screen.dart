import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Controller/User/user_controller.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_elevated_button.dart';
import 'package:kh_online_store/View/Setting/My%20Order/order_screen.dart';

import '../../Reusable Widget/cs_list_tile.dart';
import '../LogIn/log_in_screen.dart';
import 'Account Setting/My Address/my_address_screen.dart';
import 'My Profile Setting/profile_setting_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  final String defaultProfile ='https://firebasestorage.googleapis.com/v0/b/kh-online-store-559cd.firebasestorage.app/o/UserProfile.png?alt=media&token=cc21fd3b-1c4b-4109-9b90-ad32db3f8f4d';

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.deepPurpleAccent,
          child: Column(
            children: [
              Stack(
                children: [
                  Column(
                    children: [
                      // App Bar
                      AppBar(
                        title: Text(
                          ' My Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      //My Profile
                      ListTile(
                        leading: Obx(() {
                          return CircleAvatar(
                            radius: 25,
                            backgroundImage: CachedNetworkImageProvider(
                              controller.user.value.profilePicture.isNotEmpty
                                  ? controller.user.value.profilePicture
                                  : defaultProfile,
                            ),
                          );
                        }),
                        title: Obx(() {
                          return Text(
                            controller.user.value.username,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                        subtitle: Obx(() {
                          return Text(
                            controller.user.value.email,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }),
                        trailing: IconButton(
                          onPressed: () {
                            Get.to(() => ProfileSettingScreen());
                          },
                          icon: FaIcon(FontAwesomeIcons.penToSquare, size: 20),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  //Second Container
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  Header Account Setting
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Text(
                            'Account Setting',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // My Address
                        CSListTile(
                          leading: FaIcon(FontAwesomeIcons.houseUser),
                          title: 'My Address',
                          subtitle: 'Set your address',
                          onTap: () {
                            Get.to(() => MyAddressScreen());
                          },
                        ),
                        //My Order
                        CSListTile(
                          leading: FaIcon(FontAwesomeIcons.cartShopping),
                          title: 'My Order',
                          subtitle: 'List of all orders',
                          onTap: () {
                            Get.to(() => OrderScreen());
                          },
                        ),
                        // Log out Button
                        CSElevatedButton(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          text: 'Log Out',
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Logout'),
                                  content: Text(
                                    'Are you sure you want to log out?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(
                                          context,
                                        ).pop(); // Close the dialog
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Get.offAll(() => LogInScreen());
                                      },
                                      child: Text('Confirm'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}