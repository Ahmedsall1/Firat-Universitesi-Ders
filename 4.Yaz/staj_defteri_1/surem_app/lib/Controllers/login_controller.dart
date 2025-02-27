// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Views/home_screen.dart';
import '../Views/login_signup_auth.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  Future<void> login() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      isLoading.value = true;

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // User successfully logged in
        Get.snackbar('Login', 'Login successful',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
        Get.offAll(() => const HomeScreen());
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Login Error', e.message ?? 'Error occurred during login',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Login Error', 'Please enter both email and password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      Get.snackbar('Google Sign-In Error', 'Failed to sign in with Google',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void navigateToSignup() {
    Get.to(() => const SignupPage());
  }

  void forgotPassword() async {
    if (emailController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        Get.snackbar('Password Reset', 'Password reset email sent',
            backgroundColor: Colors.green,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      } catch (e) {
        Get.snackbar('Error', 'Failed to send password reset email',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Error', 'Please enter your email address',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
