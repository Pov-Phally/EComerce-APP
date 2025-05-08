import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Controller/Profile/update_controller.dart';

class UpdateUserName extends StatelessWidget {
  const UpdateUserName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Username',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: controller.updateUsernameFormKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              // Email
              TextFormField(
                controller: controller.userName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.person),
                  label: Text('UserName'),
                ),
              ),
              SizedBox(height: 10),
              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.deepPurpleAccent,
                    ),
                  ),
                  onPressed: () {
                    controller.updateUsername();
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}