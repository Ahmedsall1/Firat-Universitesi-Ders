import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneri/library.dart';
import '../data.dart';
import '../widgets/library.dart';
import 'add_library.dart';
import 'library_page.dart';

class WardrobePage extends StatefulWidget {
  const WardrobePage({super.key});

  @override
  _WardrobePageState createState() => _WardrobePageState();
}

class _WardrobePageState extends State<WardrobePage>
    with TickerProviderStateMixin {
  List<int> _selectedLibraries = [];
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  String _searchQuery = "";
  bool _isGridView = true;
  String _sortBy = 'name';
  List<String> _favorites = [];
  bool _showOnlyFavorites = false;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All Items', 'icon': Icons.grid_view},
    {'name': 'Tops', 'icon': Icons.dry_cleaning},
    {'name': 'Bottoms', 'icon': Icons.waves},
    {'name': 'Shoes', 'icon': Icons.warehouse},
    {'name': 'Accessories', 'icon': Icons.watch},
    {'name': 'Outerwear', 'icon': Icons.local_mall},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _categories.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _toggleFavorite(int libraryId) {
    setState(() {
      if (_favorites.contains(libraryId.toString())) {
        _favorites.remove(libraryId.toString());
      } else {
        _favorites.add(libraryId.toString());
      }
    });
  }

  void _sortLibraries(List<Library> libraries) {
    switch (_sortBy) {
      case 'name':
        libraries.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'date':
        // Assuming a dateAdded field is added to Library
        // libraries.sort((a, b) => b.dateAdded.compareTo(a.dateAdded));
        break;
      case 'category':
        libraries.sort((a, b) => a.category.compareTo(b.category));
        break;
    }
  }

  Widget _buildSortFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () => setState(() => _isGridView = !_isGridView),
          ),
          const VerticalDivider(width: 32),
          PopupMenuButton<String>(
            child: Row(
              children: const [
                Icon(Icons.sort),
                SizedBox(width: 4),
                Text('Sort'),
              ],
            ),
            onSelected: (String value) {
              setState(() => _sortBy = value);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'name',
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: 'date',
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem(
                value: 'category',
                child: Text('Sort by Category'),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              _showOnlyFavorites ? Icons.favorite : Icons.favorite_border,
              color: _showOnlyFavorites ? Colors.red : null,
            ),
            onPressed: () =>
                setState(() => _showOnlyFavorites = !_showOnlyFavorites),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(Library library, bool isSelected) {
    final isFavorite = _favorites.contains(library.id.toString());

    return AnimatedScale(
      scale: isSelected ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: () {
          if (_selectedLibraries.isEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LibraryPage(library: library),
              ),
            );
          } else {
            setState(() {
              if (isSelected) {
                _selectedLibraries.remove(library.id);
              } else {
                _selectedLibraries.add(library.id);
              }
            });
          }
        },
        onLongPress: () {
          setState(() {
            if (isSelected) {
              _selectedLibraries.remove(library.id);
            } else {
              _selectedLibraries.add(library.id);
            }
          });
          HapticFeedback.mediumImpact();
        },
        child: Stack(
          children: [
            LibraryCard(library: library),
            if (isSelected)
              const Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount =
        (screenWidth / 200).floor(); // Adjust grid dynamically

    var filteredLibraries = Data.libraries.where((library) {
      if (_showOnlyFavorites && !_favorites.contains(library.id.toString())) {
        return false;
      }
      return library.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    _sortLibraries(filteredLibraries);

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              )
            : const Text('Dolablarım'),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _searchQuery = '';
                  _searchController.clear();
                }
              });
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: const Color.fromARGB(255, 0, 0, 0),
          unselectedLabelColor: const Color.fromARGB(255, 0, 0, 0),
          indicatorColor: const Color.fromARGB(255, 0, 0, 0),
          tabs: _categories.map((category) {
            return Tab(
              child: Row(
                children: [
                  Icon(category['icon']),
                  const SizedBox(width: 8),
                  Text(category['name']),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      body: Column(
        children: [
          _buildSortFilterBar(),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: filteredLibraries.length,
              itemBuilder: (context, index) {
                final library = filteredLibraries[index];
                final isSelected = _selectedLibraries.contains(library.id);
                return _buildGridItem(library, isSelected);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddLibraryPage(),
            ),
          );
        },
        label: const Text('AI'),
        icon: const Icon(Icons.auto_awesome),
      ),
    );
  }
}
