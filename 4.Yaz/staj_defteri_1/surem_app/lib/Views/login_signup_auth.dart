import 'package:flutter/material.dart';
import 'package:surem/Views/welcome_screen.dart';
import '../Controllers/login_controller.dart';
import '../Controllers/signup_controller.dart';
import '../Controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_screen.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SignupController controller = Get.put(SignupController());
    final ThemeController themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => const WelcomeScreen());
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Create an Account',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    Obx(() => IconButton(
                          icon: Icon(
                            themeController.isDarkMode.value
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: Colors.yellow,
                          ),
                          onPressed: themeController.toggleTheme,
                        )),
                  ],
                ),
                const SizedBox(height: 48),
                TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person, color: Colors.yellow),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.yellow),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.yellow),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.signup,
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Sign Up'),
                    )),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Already have an account? Login',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          // Check if user is logged in or not
          if (user == null) {
            return const LoginPage();
          } else {
            return const HomeScreen();
          }
        } else {
          // Show loading while checking auth state
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome Back!',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                    Obx(() => IconButton(
                          icon: Icon(
                            themeController.isDarkMode.value
                                ? Icons.light_mode
                                : Icons.dark_mode,
                            color: Colors.yellow,
                          ),
                          onPressed: themeController.toggleTheme,
                        )),
                  ],
                ),
                const SizedBox(height: 48),
                TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, color: Colors.yellow),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.yellow),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: controller.forgotPassword,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton(
                      onPressed:
                          controller.isLoading.value ? null : controller.login,
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    )),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: controller.navigateToSignup,
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton.icon(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.loginWithGoogle,
                      icon: const Icon(Icons.g_mobiledata, size: 24),
                      label: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Login with Google'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
