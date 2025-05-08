import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Authentication/register_controller.dart';
import '../../Reusable Widget/cs_elevated_button.dart';
import '../../Reusable Widget/cs_text_form_field.dart';
import '../LogIn/log_in_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Header Register
                Text(
                  'Register Your Account',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                //Form
                Form(
                  key: controller.registerFormKey,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      //Username
                      CSTextFormField(
                        label: 'Username',
                        hintText: 'Enter your username',
                        controller: controller.regUsername,
                        prefixIcon: Icon(Icons.person),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      //Email
                      CSTextFormField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: controller.regEmail,
                        prefixIcon: Icon(Icons.mail),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      //Phone Number
                      CSTextFormField(
                        label: 'Phone Number',
                        hintText: 'Enter your phone number',
                        controller: controller.regPhoneNumber,
                        prefixIcon: Icon(Icons.phone),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      //Password
                      Obx(() {
                        return CSTextFormField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          controller: controller.regPassword,
                          prefixIcon: Icon(Icons.key),
                          obscureText: controller.isObscure.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isObscure.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              controller.isObscure.value =
                                  !controller.isObscure.value;
                            },
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 7) {
                              return 'Password must be at least 7 characters';
                            }
                            return null;
                          },
                        );
                      }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                //Register Button
                CSElevatedButton(
                  text:
                      controller.isLoading.value
                          ? 'Registering...'
                          : 'Register',
                  onPressed: () {
                    if (!controller.registerFormKey.currentState!.validate()) {
                      return;
                    }
                    controller.register();
                  },
                ),
                SizedBox(height: 10),
                //Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already have an account?',style: TextStyle(fontSize: 10),),
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => LogInScreen());
                      },
                      child: Text('Log in',style: TextStyle(fontSize: 10),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}