import 'dart:io';

import 'package:flutter/material.dart';
import 'package:oneri/look.dart';

class LookCard extends StatelessWidget {
  LookCard({super.key, required this.look});
  final Look look;

  @override
  Widget build(BuildContext context) {
    // Map the categories to widgets for display
    List<Widget> imageWidgets = look.imagePaths.entries.map((entry) {
      final category = entry.key;
      final path = entry.value;

      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              File(path),
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ],
      );
    }).take(3).toList();

    // Fill remaining spots with placeholders if fewer than 3 images exist
    while (imageWidgets.length < 3) {
      imageWidgets.add(
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: 40,
                height: 40,
                color: Colors.grey.shade200,
                child: Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Empty",
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Card(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          shadowColor: const Color.fromARGB(255, 153, 159, 165).withOpacity(0.2),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              width: 180,
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Display the images in a row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageWidgets,
                    ),
                    const SizedBox(height: 5),
                    // Display the title of the look
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 4,
                      shadowColor: Colors.blue.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Text(
                          look.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
