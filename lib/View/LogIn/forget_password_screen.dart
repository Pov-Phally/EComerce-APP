import 'package:flutter/material.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_text_form_field.dart';

import '../../Controller/Authentication/forgot_password_controller.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final forgetPasswordController = Get.put(ForgotPasswordController());
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forget Password',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Please enter your email address to receive a link to create a new password via email.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Form(
                key: forgetPasswordController.resetPasswordFormKey,
                child: CSTextFormField(
                  label: 'Email',
                  prefixIcon: Icon(Icons.send),
                  hintText: 'Enter your email address',
                  controller: forgetPasswordController.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.deepPurpleAccent,
                    ),
                  ),
                  onPressed: () {
                    if (forgetPasswordController
                        .resetPasswordFormKey
                        .currentState!
                        .validate()) {
                      forgetPasswordController.resetPassword(
                        forgetPasswordController.emailController.text,
                      );
                    }
                  },
                  child: Text(
                    'Submit',
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