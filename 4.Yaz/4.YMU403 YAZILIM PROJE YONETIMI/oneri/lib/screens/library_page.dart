import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking new images
import 'package:oneri/library.dart';

class LibraryPage extends StatefulWidget {
  final Library library;

  const LibraryPage({Key? key, required this.library}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<int> _selectedImages = []; // Track selected images for deletion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.library.title),
            SizedBox(
              width: 5,
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(widget.library.category,
                  style: TextStyle(background: Paint(), color: Colors.white)),
            ),
          ],
        ),
        actions: [
          if (_selectedImages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deleteSelectedImages,
            ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewImage,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 images per row
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: widget.library.imagePaths.length,
        itemBuilder: (context, index) {
          final imagePath = widget.library.imagePaths[index];
          final isSelected = _selectedImages.contains(index);

          return GestureDetector(
            onTap: () {
              // Toggle selection for deletion
              setState(() {
                if (isSelected) {
                  _selectedImages.remove(index);
                } else {
                  _selectedImages.add(index);
                }
              });
            },
            child: Stack(
              children: [
                Image.file(
                  File(imagePath),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                if (isSelected)
                  Container(
                    color: Colors.black54,
                    child: const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteSelectedImages() async {
    setState(() {
      _selectedImages.sort((a, b) => b.compareTo(a));
      for (int index in _selectedImages) {
        widget.library.imagePaths.removeAt(index);
      }
      _selectedImages.clear();
    });
  }

  Future<void> _addNewImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.library.imagePaths.add(pickedFile.path);
      });
    }
  }
}
