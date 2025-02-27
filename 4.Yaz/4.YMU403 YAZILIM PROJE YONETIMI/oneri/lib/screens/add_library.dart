import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../data.dart';
import '../library.dart';
import '../api/api_service.dart';
import 'home.dart';
import 'wardrobe.dart';

class AddLibraryPage extends StatefulWidget {
  const AddLibraryPage({super.key});
  @override
  _AddLibraryPageState createState() => _AddLibraryPageState();
}

class _AddLibraryPageState extends State<AddLibraryPage> {
  ApiService api = ApiService();
  final TextEditingController _titleController = TextEditingController();
  String _selected = "pantalon";
  final List<String> _selectedImages = [];
  List<String> list = <String>['pantalon', 'Shoes', 'Jacket', 'Sweater'];
  bool _isLoading = false;

  Future<File> renameImageWithCategory(
      File image, String category, int id) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFileName = '${category}_${id}.jpg';
    final newPath = '${appDir.path}/$newFileName';
    return image.rename(newPath);
  }

  Future<void> _pickImages() async {
    setState(() => _isLoading = true);
    try {
      final picker = ImagePicker();
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null) {
        for (var file in pickedFiles) {
          final savedPath = await _saveImageToLocalDirectory(file);
          _selectedImages.add(savedPath);
        }
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<String> _saveImageToLocalDirectory(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = file.name;
    final savedImage = await File(file.path).copy('${appDir.path}/$fileName');
    return savedImage.path;
  }

  void _saveLibrary() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a library title')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      Library lib = Library(
        id: Data.ID,
        title: _titleController.text,
        imagePaths: _selectedImages,
        category: _selected,
      );
      Data.ID++;
      Data.libraries.add(lib);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(selectedIndex: 1),
        ),
        (route) => false,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dolap Oluştur',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title and Category Section
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _titleController,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Dolap Adı',
                            labelStyle: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.blue, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selected,
                              isExpanded: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              borderRadius: BorderRadius.circular(12),
                              items: list.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() => _selected = value!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Image Selection Section
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _pickImages,
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          label: const Text('Fotograf Ekle'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        if (_selectedImages.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Text(
                            '${_selectedImages.length} images selected',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                // Image Grid
                Expanded(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _selectedImages.isEmpty
                        ? Center(
                            child: Text(
                              'Dolap boş',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                            ),
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.file(
                                      File(_selectedImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedImages.removeAt(index);
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                ),

                // Save Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: _selectedImages.isEmpty ? null : _saveLibrary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.save),
                        SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Kaydet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
