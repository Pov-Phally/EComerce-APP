import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kh_online_store/Controller/Authentication/log_in_controller.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_elevated_button.dart';
import 'package:kh_online_store/Reusable%20Widget/cs_text_form_field.dart';
import 'package:kh_online_store/View/Register/register_screen.dart';
import 'forget_password_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final LogInController controller = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Header Welcome
              Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    // Email
                    CSTextFormField(
                      label: 'Email',
                      hintText: 'Enter your email',
                      controller: controller.logEmail,
                      prefixIcon: Icon(Icons.person),
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
                    // Password
                    Obx(() {
                      return CSTextFormField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        controller: controller.logPassword,
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
                          if (value!.length < 7) {
                            return 'Password must be at least 7 characters';
                          }
                          if (value.isEmpty) {
                            return 'Please enter your password';
                          }
                          //check if  password is correct
                          return null;
                        },
                      );
                    }),
                  ],
                ),
              ),
              // Remember me and Forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return Checkbox(
                          value: controller.rememberMe.value,
                          onChanged:
                              (value) => controller.rememberMe.value = value!,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        );
                      }),
                      Text('Remember me',style: TextStyle(fontSize: 10),),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => ForgetPasswordScreen());
                    },
                    child: Text('Forgot password?',style: TextStyle(fontSize: 10),),
                  ),
                ],
              ),
              // Login Button
              Obx(() {
                return CSElevatedButton(
                  text: controller.isLoading.value ? 'Logging in...' : 'Log In',
                  onPressed: () {
                    if (!controller.loginFormKey.currentState!.validate()) {
                      return;
                    }
                    controller.login();
                  },
                );
              }),
              // Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?',style: TextStyle(fontSize: 10),),
                  TextButton(
                    onPressed: () {
                      Get.to(() => RegisterScreen());
                    },
                    child: Text('Register',style: TextStyle(fontSize: 10),),
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