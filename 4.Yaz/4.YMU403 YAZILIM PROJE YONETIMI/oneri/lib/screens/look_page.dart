import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oneri/look.dart';

class LookPage extends StatelessWidget {
  final Look look;

  LookPage({super.key, required this.look});

  @override
  Widget build(BuildContext context) {
    // Define a custom order for the categories
    final List<String> categoryOrder = ['Jacket', 'Sweater', 'Pantalon', 'Shoes'];

    // Sort the imagePaths by categoryOrder
    final sortedEntries = look.imagePaths.entries.toList()
      ..sort((a, b) => categoryOrder.indexOf(a.key).compareTo(categoryOrder.indexOf(b.key)));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          look.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            
            // Display Sorted Outfit Parts
            ...sortedEntries.map((entry) {
              final category = entry.key;
              final imagePath = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        // Open full-screen image viewer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FullScreenImageView(
                              imagePath: imagePath,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(
                          File(imagePath),
                          // height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  FullScreenImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: Image.file(
            File(imagePath),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
