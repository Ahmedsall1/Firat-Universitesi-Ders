import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _selectedImage;

  Future<void> _pickAndSaveImage() async {
    try {
      // Use ImagePicker to select an image
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        // Get the directory to save the file
        final Directory appDir = await getApplicationDocumentsDirectory();

        // Save the image in the "images" folder
        final String imagesDir = '${appDir.path}/images';
        final Directory dir = Directory(imagesDir);
        if (!dir.existsSync()) {
          dir.createSync(recursive: true);
        }

        // Save the image file to the folder
        final String filePath = '${dir.path}/${pickedFile.name}';
        final File savedImage = await File(pickedFile.path).copy(filePath);
        print(filePath);

        setState(() {
          _selectedImage = savedImage;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image saved to $filePath')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick and Save Image'),
        backgroundColor: Colors.green[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(
                    _selectedImage!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Text('No image selected.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickAndSaveImage,
              child: Text('Pick and Save Image'),
              style: ElevatedButton.styleFrom(
              ),
            ),
          ],
        ),
      ),
    );
  }
}
