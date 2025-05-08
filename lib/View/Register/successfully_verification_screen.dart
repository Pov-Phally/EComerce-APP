import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../LogIn/log_in_screen.dart';

class SuccessfullyVerificationScreen extends StatelessWidget {
  const SuccessfullyVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Verification Successful',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Your account has been successfully verified!',
              style: TextStyle(fontSize: 20.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAll(() => LogInScreen());
                },
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.deepPurpleAccent)),
                child: Text('Go to Login',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}