import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/profile_controller.dart'; // ProfileController'ı ekleyin
import 'profile_screen.dart'; // ProfileScreen'i ekleyin

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _imageSelected = false;
  bool _imageProcessed = false;
  late AnimationController _fadeController;
  late AnimationController _processController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _processAnimation;

  final ProfileController profileController = Get.put(ProfileController()); // ProfileController'ı ekledik

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _processController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _processAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_processController);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _processController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Image Enhancer'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const ProfileScreen()), // ProfileScreen'e yönlendirir
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              child: Obx(() {
                // Profil resmi URL'sini dinamik hale getirdik
                String? imageUrl = profileController.profileImageUrl.value;
                
                return CircleAvatar(
                  backgroundImage: imageUrl != null
                      ? NetworkImage(imageUrl) // Kullanıcıya ait profil resmi
                      : const AssetImage('assets/default_profile.png')
                          as ImageProvider, // Eğer profil resmi yoksa varsayılan resim göster
                  radius: 20,
                );
              }),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _imageSelected = true;
                      _imageProcessed = false;
                    });
                    _fadeController.forward(from: 0.0);
                  },
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text('Select Image'),
                ),
              ),
              if (_imageSelected) ...[
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.network(
                      'https://i.pravatar.cc/1000',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ElevatedButton(
                    onPressed: () {
                      _processController.forward(from: 0.0);
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          _imageProcessed = true;
                        });
                        _fadeController.forward(from: 0.0);
                        Get.snackbar(
                            colorText: Colors.white,
                            backgroundColor: Colors.green,
                            'Process Completed',
                            'The process has been finished successfully',
                            duration: const Duration(seconds: 3),
                            snackPosition: SnackPosition.BOTTOM);
                      });
                    },
                    child: const Text('Process'),
                  ),
                ),
              ],
              if (_imageProcessed) ...[
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image.network(
                      'https://i.pravatar.cc/1000',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.snackbar('Save Image',
                          'Save image functionality to be implemented',
                          snackPosition: SnackPosition.BOTTOM);
                    },
                    icon: const Icon(Icons.save_alt),
                    label: const Text('Save'),
                  ),
                ),
              ],
              if (_imageSelected && !_imageProcessed) ...[
                const SizedBox(height: 24),
                AnimatedBuilder(
                  animation: _processAnimation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _processAnimation.value,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
