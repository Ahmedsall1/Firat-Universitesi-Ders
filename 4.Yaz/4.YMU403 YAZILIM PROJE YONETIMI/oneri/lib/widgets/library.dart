import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

import '../library.dart';

class LibraryCard extends StatelessWidget {
  LibraryCard({
    super.key,
    required this.library,
  });
  final Library library;
  int id = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> imageWidgets = library.imagePaths
        .take(9)
        .map((path) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.file(
                File(path),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ))
        .toList();

    while (imageWidgets.length < 9) {
      imageWidgets.add(
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: SizedBox(
            width: 50,
            height: 50,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius:BorderRadius.all(Radius.circular(5.0)),
                color: Colors.black12, // Fill with a white box
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        Card(
          color: Colors.white,
          margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(color: Color.fromARGB(255, 155, 206, 253)),
          ),
          elevation: 8,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: SizedBox(
              width: 175,
              height: 175,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: imageWidgets.sublist(0, 3),
                    ),
                    Row(
                      children: imageWidgets.sublist(3, 6),
                    ),
                    Row(
                      children: imageWidgets.sublist(6, 9),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Text(library.title),
        Text(library.category)
      ],
    );
  }
}
