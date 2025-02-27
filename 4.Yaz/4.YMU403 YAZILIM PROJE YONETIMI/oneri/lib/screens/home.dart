import 'package:flutter/material.dart';

import 'add_library.dart';
import 'my_looks.dart';
import 'wardrobe.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.selectedIndex});
  late int selectedIndex;

  @override
  State<MyHomePage> createState() => _MyHomePageState(selectedIndex);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState(int page) {
    _selectedIndex = page;
  }
  int _selectedIndex = 0;

  // List of pages for navigation
  final List<Widget> _pages = [MyLooksPage(), WardrobePage(), AddLibraryPage()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green[900], // Highlight color
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.bubble_chart), // Circle bubbles icon
            label: 'Öneriler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checkroom), // Wardrobe hanger icon
            label: 'Dolablarım',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_add), // Wardrobe hanger icon
            label: 'Dolap Ekle',
          ),
        ],
      ),
    );
  }
}
