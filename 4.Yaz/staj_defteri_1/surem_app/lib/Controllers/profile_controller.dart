// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:surem/Views/welcome_screen.dart';

class ProfileController extends GetxController {
  final profileImageUrl = Rx<String?>(null);
  final username = ''.obs;
  final email = ''.obs;
  final isDarkMode = false.obs;
  final currentLanguage = 'English'.obs;

  static const int ONE_MEGABYTE = 1024 * 1024;

  @override
  void onInit() {
    super.onInit();
    // Kullanıcı bilgilerini Firebase'den getir
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      username.value = user.displayName ?? user.email!.split('@')[0];
      email.value = user.email!;
      profileImageUrl.value = user.photoURL;
    }
  }

  // Profil resmini değiştirme
  void changeProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      File imageFile = File(image.path);
      try {
        // Resmi sıkıştır
        List<int>? compressedImage = await FlutterImageCompress.compressWithFile(
          imageFile.absolute.path,
          minWidth: 1024,
          minHeight: 1024,
          quality: 85,
        );

        if (compressedImage == null) {
          throw Exception('Failed to compress image');
        }

        // Sıkıştırılmış resim boyutunu kontrol et
        if (compressedImage.length > ONE_MEGABYTE) {
          throw Exception('Compressed image is still too large');
        }

        // Firebase Storage'a resmi yükle
        String fileName = 'profile_${FirebaseAuth.instance.currentUser!.uid}.jpg';
        Reference storageRef = FirebaseStorage.instance
            .ref('surem-plus.appspot.com')
            .child('profile_images/$fileName');
        UploadTask uploadTask = storageRef.putData(Uint8List.fromList(compressedImage));
        
        // Yükleme tamamlanınca URL'yi al
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        
        // Firebase kullanıcı profil resmini güncelle
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(downloadUrl);
        
        // Yerel durumu güncelle
        profileImageUrl.value = downloadUrl;
        
        Get.snackbar(
          'Profile Image',
          'Profile image updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM
        );
      } catch (e) {
        print('Error: $e');
        Get.snackbar(
          'Error',
          'Failed to update profile image: ${e.toString()}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM
        );
      }
    }
  }

  // Profil resmini kaldırma
  void removeProfileImage() async {
    try {
      // Firebase Auth'taki fotoğraf URL'sini kaldır
      await FirebaseAuth.instance.currentUser!.updatePhotoURL("");
      
      // Firebase Storage'dan resmi sil
      if (profileImageUrl.value != null) {
        String fileName = 'profile_${FirebaseAuth.instance.currentUser!.uid}.jpg';
        Reference storageRef = FirebaseStorage.instance
            .ref('surem-plus.appspot.com')
            .child('profile_images/$fileName');
        await storageRef.delete();
      }
      
      // Yerel durumu güncelle
      profileImageUrl.value = null;
      
      Get.snackbar(
        'Profile Image',
        'Profile image removed successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM
      );
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Failed to remove profile image',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  // Kullanıcı adını değiştirme
  void changeUsername(String newUsername) {
    username.value = newUsername;
    FirebaseAuth.instance.currentUser?.updateDisplayName(newUsername);
  }

  // Şifre sıfırlama e-postası gönderme
  void changePassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email.value);
      Get.snackbar('Password Reset', 'Password reset email sent',
          backgroundColor: Colors.green, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to send password reset email',
          backgroundColor: Colors.red, colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Çıkış yapma
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const WelcomeScreen());
  }

  // Tema değiştirme
  void toggleTheme() {
    isDarkMode.toggle();
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Dil değiştirme
  void changeLanguage(String language) {
    currentLanguage.value = language;
    // Burada dil değiştirme mantığını implement edebilirsiniz
  }

  // AppBar'da gösterilecek ikonları döndür
  List<Widget> getAppBarActions() {
    return [
      IconButton(
        icon: Icon(
          isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
          size: 32,
          color: isDarkMode.value ? Colors.yellow : Colors.black,
        ),
        onPressed: toggleTheme,
      ),
      IconButton(
        icon: Icon(Icons.language,
            size: 32, color: isDarkMode.value ? Colors.yellow : Colors.black),
        onPressed: () => _showLanguageDialog(),
      ),
    ];
  }

  // Dil değiştirme dialogunu göster
  void _showLanguageDialog() {
    final List<String> languages = ['English', 'Español', 'Français'];

    Get.dialog(
      AlertDialog(
        title: const Text('Select Language'),
        content: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: languages.map((lang) => RadioListTile<String>(
            title: Text(lang),
            value: lang,
            groupValue: currentLanguage.value,
            onChanged: (value) {
              if (value != null) {
                changeLanguage(value);
              }
            },
          )).toList(),
        )),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Get.back(),
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
