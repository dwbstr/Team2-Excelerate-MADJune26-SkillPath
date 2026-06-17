import 'package:flutter/material.dart';
import 'program_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredPrograms = [];

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.computer_rounded, 'label': 'Tech'},
    {'icon': Icons.brush_rounded, 'label': 'Design'},
    {'icon': Icons.business_center_rounded, 'label': 'Business'},
    {'icon': Icons.campaign_rounded, 'label': 'Marketing'},
  ];

  final List<Map<String, String>> _featuredPrograms = [
    {
      'title': 'Flutter for Beginners',
      'subtitle': 'Learn from scratch and build app',
      'tag': 'Beginner',
    },
    {
      'title': 'UI/UX Design Basics',
      'subtitle': 'Design beautiful interfaces',
      'tag': 'Beginner',
    },
    {
      'title': 'Digital Marketing',
      'subtitle': 'Grow your brand online',
      'tag': 'Intermediate',
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredPrograms = _featuredPrograms;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _filteredPrograms = _featuredPrograms;
      } else {
        _filteredPrograms = _featuredPrograms
            .where((program) => program['title']!
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Color(0xFF1A1A2E)),
          onPressed: () {},
        ),
        title: const Text(
          'skillpath',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF1A1A2E)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            const Text(
              'HI, Learner 👋',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const Text(
              'what do you want to learn today?',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF888888),
              ),
            ),

            const SizedBox(height: 20),

            // Search bar
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFEEEEEE)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search programs, skills....',
                        hintStyle: TextStyle(
                            color: Color(0xFFBBBBBB), fontSize: 13),
                        prefixIcon: Icon(Icons.search_rounded,
                            color: Color(0xFFBBBBBB)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 13),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFEEEEEE)),
                  ),
                  child: const Icon(Icons.tune_rounded,
                      color: Color(0xFF4A90D9)),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Categories
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _categories.map((cat) {
                return Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0FE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        cat['icon'] as IconData,
                        color: const Color(0xFF4A90D9),
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      cat['label'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF555555),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),

            const SizedBox(height: 28),

            // Featured Programs
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Featured Programs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProgramListScreen()),
                    );
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      color: Color(0xFF4A90D9),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Program cards horizontal scroll
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _filteredPrograms.length,
                itemBuilder: (context, index) {
                  final program = _filteredPrograms[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProgramListScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 190,
                      margin: const EdgeInsets.only(right: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image placeholder
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDDE6F5),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(14),
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle_fill_rounded,
                                size: 40,
                                color: Color(0xFF4A90D9),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  program['title']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A1A2E),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  program['subtitle']!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF888888),
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom navigation bar - matches wireframe
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProgramListScreen()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4A90D9),
        unselectedItemColor: const Color(0xFFAAAAAA),
        backgroundColor: Colors.white,
        elevation: 8,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: 'notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded),
            label: 'friends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
