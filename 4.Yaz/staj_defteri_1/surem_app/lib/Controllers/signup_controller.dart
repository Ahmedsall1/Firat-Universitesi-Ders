import 'package:flutter/material.dart';
import '../Views/home_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> signup() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // Update user profile with name
        await userCredential.user?.updateDisplayName(nameController.text);
        // User successfully signed up
        Get.snackbar('Signup', 'Signup successful',
            backgroundColor: Colors.green, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        Get.offAll(() => const HomeScreen());
      } on FirebaseAuthException catch (e) {
        Get.snackbar(
            'Signup Error', e.message ?? 'Error occurred during signup',
            backgroundColor: Colors.red, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Signup Error', 'Please fill in all fields',
          backgroundColor: Colors.red, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
