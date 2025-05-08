import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Authentication/email_verification_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key, this.email});
  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EmailVerificationController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text(
              'A verification email has been sent to your email address. Please check your inbox and follow the instructions to verify your email.',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.start,
              softWrap: true,
            ),
            Text(
              email ?? '',
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.start,
              softWrap: true,
            ),
            SizedBox(height: 10),
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.isEmailVerified.value
                      ? () {
                    controller.checkEmailVerificationStatus();
                  }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.deepPurpleAccent,
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
            TextButton(
              onPressed: () {
                controller.sendEmailVerification();
              },
              child: Text('Resend Email'),
            ),
            Obx(() {
              return Text(
                controller.isEmailVerified.value
                    ? ''
                    : 'Please verify your email before clicking Continue.',
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              );
            }),
          ],
        ),
      ),
    );
  }
}