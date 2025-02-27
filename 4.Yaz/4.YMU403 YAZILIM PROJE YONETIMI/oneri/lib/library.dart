import 'package:flutter/material.dart';

class Library {
  late int id;
  late String title;
  late String category;
  late List<String> imagePaths;
  Library({required this.id, required this.title, required this.imagePaths, required this.category});
}
