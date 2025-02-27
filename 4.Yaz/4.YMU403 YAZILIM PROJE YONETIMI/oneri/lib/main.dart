import 'package:flutter/material.dart';
import 'package:oneri/screens/home.dart';

import 'data.dart';
import 'library.dart';
import 'look.dart';

void main() {
  String image = "/Users/main/Desktop/elbiseler/ayakkabi_1.png";
  String ayak_1 = "/Users/main/Desktop/elbiseler/ayakkabi_2.png";
  String ayak_2 = "/Users/main/Desktop/elbiseler/ayakkabi_3.png";
  String ayak_3 = "/Users/main/Desktop/elbiseler/ayakkabi_4.png";
  String ayak_4 = "/Users/main/Desktop/elbiseler/ayakkabi_5.png";
  String image_1 = "/Users/main/Desktop/elbiseler/kazak_1.png";
  String kazak_2 = "/Users/main/Desktop/elbiseler/kazak_2.png";
  String kazak_3 = "/Users/main/Desktop/elbiseler/kazak_3.png";
  String kazak_4 = "/Users/main/Desktop/elbiseler/kazak_4.png";
  String kazak_5 = "/Users/main/Desktop/elbiseler/kazak_5.png";
  String image_2 = "/Users/main/Desktop/elbiseler/pantolon_1.png";
  String image_3 = "/Users/main/Desktop/elbiseler/pantolon_2.png";
  String image_4 = "/Users/main/Desktop/elbiseler/pantolon_3.png";
  String image_5 = "/Users/main/Desktop/elbiseler/pantolon_4.png";
  String image_6 = "/Users/main/Desktop/elbiseler/pantolon_5.png";
  Data.libraries.add(Library(
      id: Data.ID,
      title: "MY",
      imagePaths: [image_3, image_4, image_2, image_5, image_6],
      category: "pantalon"));
  Data.ID++;
  Data.libraries.add(Library(
      id: Data.ID,
      title: "MY",
      imagePaths: [kazak_2, kazak_3, kazak_4, kazak_5, image_1],
      category: "Sweater"));
  Data.ID++;
  Data.libraries.add(Library(
      id: Data.ID,
      title: "MY",
      imagePaths: [image, ayak_1, ayak_2, ayak_3, ayak_4],
      category: "shoes"));
  Data.ID++;

// Adding looks with category-to-image mapping
  Data.looks.add(
    Look(
      id: Data.ID,
      title: "Home",
      imagePaths: {
        "Shoes": image,
        "Sweater": kazak_2,
        "Pantalon": image_2,
      },
    ),
  );
  Data.ID++;

  Data.looks.add(
    Look(
      id: Data.ID,
      title: "Okul",
      imagePaths: {
        "Shoes": ayak_1,
        "Sweater": kazak_3,
        "Pantalon": image_3,
      },
    ),
  );
  Data.ID++;

  Data.looks.add(
    Look(
      id: Data.ID,
      title: "Misafir",
      imagePaths: {
        "Shoes": ayak_2,
        "Sweater": kazak_4,
        "Pantalon": image_4,
      },
    ),
  );
  Data.ID++;

  Data.looks.add(
    Look(
      id: Data.ID,
      title: "Test",
      imagePaths: {
        "Shoes": ayak_3,
        "Sweater": kazak_5,
        "Pantalon": image_6,
      },
    ),
  );
  Data.ID++;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: MyHomePage(selectedIndex: 0),
    );
  }
}
