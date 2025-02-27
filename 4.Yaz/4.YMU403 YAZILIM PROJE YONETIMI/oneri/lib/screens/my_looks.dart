import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:oneri/widgets/looks.dart';
import '../data.dart';
import 'look_page.dart';

class MyLooksPage extends StatefulWidget {
  const MyLooksPage({super.key});

  @override
  _MyLooksPageState createState() => _MyLooksPageState();
}

class _MyLooksPageState extends State<MyLooksPage> with TickerProviderStateMixin {
  List<int> _selectedLibraries = [];
  late AnimationController _fabAnimationController;
  final ScrollController _scrollController = ScrollController();
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fabAnimationController.forward();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (_showFab) {
        setState(() {
          _showFab = false;
          _fabAnimationController.reverse();
        });
      }
    }
    if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
      if (!_showFab) {
        setState(() {
          _showFab = true;
          _fabAnimationController.forward();
        });
      }
    }
  }

  void _deleteSelectedLooks() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Delete Selected Looks?'),
          content: Text(
            'Are you sure you want to delete ${_selectedLibraries.length} selected look${_selectedLibraries.length == 1 ? '' : 's'}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  Data.looks.removeWhere(
                      (look) => _selectedLibraries.contains(look.id));
                  _selectedLibraries.clear();
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Looks deleted successfully'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedLibraries.isNotEmpty
          ? AppBar(
              backgroundColor: Colors.black,
              title: Text(
                '${_selectedLibraries.length} Selected',
                style: const TextStyle(color: Colors.white),
              ),
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () {
                  setState(() {
                    _selectedLibraries.clear();
                  });
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.white),
                  onPressed: _deleteSelectedLooks,
                ),
              ],
            )
          : AppBar(
              title: const Text(
                'My Looks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: false,
              // backgroundColor: Colors.transparent,
              elevation: 0,
            ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final look = Data.looks[index];
                  final isSelected = _selectedLibraries.contains(look.id);
                  
                  return AnimatedScale(
                    scale: isSelected ? 0.95 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () {
                        if (_selectedLibraries.isEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LookPage(look: look),
                            ),
                          );
                        } else {
                          setState(() {
                            if (isSelected) {
                              _selectedLibraries.remove(look.id);
                            } else {
                              _selectedLibraries.add(look.id);
                            }
                          });
                        }
                      },
                      onLongPress: () {
                        setState(() {
                          if (isSelected) {
                            _selectedLibraries.remove(look.id);
                          } else {
                            _selectedLibraries.add(look.id);
                          }
                        });
                        HapticFeedback.mediumImpact();
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: LookCard(look: look),
                          ),
                          if (isSelected)
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: Data.looks.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ScaleTransition(
        scale: CurvedAnimation(
          parent: _fabAnimationController,
          curve: Curves.easeOut,
        ),
        child: FloatingActionButton.extended(
          onPressed: () {

          },

          icon: const Icon(Icons.add),
          label: const Text('New Look'),
        ),
      ),
    );
  }
}