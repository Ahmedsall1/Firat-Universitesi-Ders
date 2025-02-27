import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_signup_auth.dart';
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _showLanguageDialog(BuildContext context) {
    final List<String> languages = ['English', 'Español', 'Français'];
    final RxString currentLanguage = 'English'.obs;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Language'),
          content: Obx(() => Column(
            mainAxisSize: MainAxisSize.min,
            children: languages.map((lang) => RadioListTile<String>(
              title: Text(lang),
              value: lang,
              groupValue: currentLanguage.value,
              onChanged: (value) {
                if (value != null) {
                  currentLanguage.value = value;
                  // TODO: Implement language change logic here
                  Get.updateLocale(Locale(value.substring(0, 2).toLowerCase()));
                }
              },
            )).toList(),
          )),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // TODO: Implement any additional logic needed when confirming language change
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              size: 32,
              color: Get.isDarkMode ? Colors.yellow : Colors.black,
            ),
            onPressed: () {
              Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.language,
                size: 32, color: Get.isDarkMode ? Colors.yellow : Colors.black),
            onPressed: () => _showLanguageDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Image.asset(
                  'assets/Logo2.png',
                  width: 240,
                  height: 64,
                ),
              ),
              const SizedBox(height: 24),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: Text(
                  'AI Image Enhancer',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: child,
                  );
                },
                child: Text(
                  'Enhance Your Images Instantly',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 48),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const LoginPage()),
                  child: const Text('Get Started'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
