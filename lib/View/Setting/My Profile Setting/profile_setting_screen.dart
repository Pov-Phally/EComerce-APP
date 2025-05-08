import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/User/user_controller.dart';
import 'Update Screen/update_username.dart';

class ProfileSettingScreen extends StatelessWidget {
  ProfileSettingScreen({super.key});
  final String userProfile =
      'https://firebasestorage.googleapis.com/v0/b/kh-online-store-559cd.firebasestorage.app/o/UserProfile.png?alt=media&token=cc21fd3b-1c4b-4109-9b90-ad32db3f8f4d';

  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Setting',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Profile pic
              Obx(() {
                final networkImage = controller.user.value.profilePicture;
                final image =
                    networkImage.isNotEmpty ? networkImage : userProfile;
                if (controller.profileLoading.value &&
                    controller.imageUploading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  );
                }
                return CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider(image),
                );
              }),
              //Change profile pic
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  controller.uploadProfilePicture();
                },
                child: Text(
                  'Change profile Picture',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              //Profile information
              Text(
                'Profile information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              //Username
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Username',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Obx(() {
                      return Text(
                        controller.user.value.username,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.to(() => UpdateUserName());
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              //Email
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Obx(() {
                      return Text(
                        controller.user.value.email,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Divider(),
              SizedBox(height: 10),
              //Personal information
              Text(
                'Personal information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              //User ID
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'User ID',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      controller.user.value.id,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.copy_all, size: 18, color: Colors.black54),
                  ),
                ],
              ),
              //Phone number
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Phone number',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Obx(() {
                      return Text(
                        controller.user.value.phoneNumber,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                      color: Colors.black54,
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