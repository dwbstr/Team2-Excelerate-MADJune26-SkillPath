import 'package:flutter/material.dart';
import 'program_detail_screen.dart';

class ProgramListScreen extends StatefulWidget {
  const ProgramListScreen({super.key});

  @override
  State<ProgramListScreen> createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  int _selectedFilter = 1; // 0=popular, 1=All, 2=beginner, 3=Advanced, 4=Latest

  final List<String> _filters = ['popular', 'All', 'beginner', 'Advanced', 'Latest'];

  final List<Map<String, String>> _programs = [
    {
      'title': 'Flutter for Beginners',
      'description': 'Learn Flutter from scratch and build your first mobile app with hands-on projects.',
      'duration': '4 weeks',
      'level': 'Beginner',
      'rating': '4.8',
      'reviews': '120',
    },
    {
      'title': 'UI/UX Design Fundamentals',
      'description': 'Master the principles of user interface and experience design using modern tools.',
      'duration': '3 weeks',
      'level': 'Beginner',
      'rating': '4.6',
      'reviews': '98',
    },
    {
      'title': 'Digital Marketing Bootcamp',
      'description': 'Learn SEO, social media, content marketing, and paid advertising strategies.',
      'duration': '5 weeks',
      'level': 'Intermediate',
      'rating': '4.7',
      'reviews': '215',
    },
    {
      'title': 'Python for Data Science',
      'description': 'Explore data analysis, visualization, and machine learning using Python.',
      'duration': '6 weeks',
      'level': 'Advanced',
      'rating': '4.9',
      'reviews': '340',
    },
    {
      'title': 'Business Strategy Essentials',
      'description': 'Understand core business strategy frameworks and apply them to real scenarios.',
      'duration': '4 weeks',
      'level': 'Intermediate',
      'rating': '4.5',
      'reviews': '88',
    },
    {
      'title': 'Graphic Design with Canva',
      'description': 'Create stunning visual content for social media, presentations, and branding.',
      'duration': '2 weeks',
      'level': 'Beginner',
      'rating': '4.4',
      'reviews': '175',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1A1A2E), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Programs',
          style: TextStyle(
            color: Color(0xFF1A1A2E),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded, color: Color(0xFF1A1A2E)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F7FA),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search programs...',
                  hintStyle:
                      TextStyle(color: Color(0xFFBBBBBB), fontSize: 13),
                  prefixIcon:
                      Icon(Icons.search_rounded, color: Color(0xFFBBBBBB)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Filter chips
          Container(
            color: Colors.white,
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedFilter == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4A4A6A)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF4A4A6A)
                            : const Color(0xFFDDDDDD),
                      ),
                    ),
                    child: Row(
                      children: [
                        if (isSelected)
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(Icons.check,
                                size: 12, color: Colors.white),
                          ),
                        Text(
                          _filters[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF555555),
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Program list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _programs.length,
              itemBuilder: (context, index) {
                final program = _programs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgramDetailScreen(
                          program: program,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Thumbnail
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDE6F5),
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_fill_rounded,
                              color: Color(0xFF4A90D9),
                              size: 36,
                            ),
                          ),
                        ),

                        // Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  program['title']!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1A1A2E),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  program['description']!,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF888888),
                                    height: 1.4,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outline_rounded,
                                      size: 13,
                                      color: Color(0xFF888888),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Today · ${program['duration']}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF888888),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Play arrow
                        const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: Color(0xFF4A90D9),
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}