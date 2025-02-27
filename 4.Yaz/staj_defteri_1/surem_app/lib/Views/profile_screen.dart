import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions:
            controller.getAppBarActions(), // Tema ve dil ikonlarını ekledim
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profil Resmi ve Düzenleme Butonu
              Obx(() => Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: controller.profileImageUrl.value !=
                                null
                            ? NetworkImage(controller.profileImageUrl.value!)
                            : const AssetImage('assets/default_profile.png')
                                as ImageProvider,
                      ),
                      GestureDetector(
                        onTap: controller.changeProfileImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit,
                              size: 20, color: Colors.black),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 24),
              // Kullanıcı Adı Alanı
              Obx(() => TextField(
                    controller:
                        TextEditingController(text: controller.username.value),
                    onChanged: controller.changeUsername,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr, // Soldan sağa yazı
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  )),
              const SizedBox(height: 16),
              // E-posta Bilgisi
              Obx(() => Text(
                    controller.email.value,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  )),
              const SizedBox(height: 8),
              // Şifre Bilgisi

              const SizedBox(height: 24),
              // Şifre Değiştirme Butonu
              ElevatedButton(
                onPressed: controller.changePassword,
                child: const Text('Change Password'),
              ),
              const SizedBox(height: 48),
              // Çıkış Yap Butonu
              OutlinedButton(
                onPressed: controller.logout,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
