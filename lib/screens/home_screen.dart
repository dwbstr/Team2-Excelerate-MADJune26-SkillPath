import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../services/user_session.dart';
import 'program_list_screen.dart';
import 'dashboard_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'label': 'Tech', 'icon': Icons.computer_rounded},
    {'label': 'Design', 'icon': Icons.brush_rounded},
    {'label': 'Business', 'icon': Icons.business_center_rounded},
    {'label': 'Marketing', 'icon': Icons.campaign_rounded},
  ];

  final List<Map<String, String>> _featured = [
    {
      'title': 'Flutter for Beginners',
      'subtitle': 'Build your first mobile app',
      'level': 'Beginner',
      'category': 'Tech',
      'rating': '4.8',
    },
    {
      'title': 'UI/UX Design Fundamentals',
      'subtitle': 'Design beautiful interfaces',
      'level': 'Beginner',
      'category': 'Design',
      'rating': '4.6',
    },
    {
      'title': 'Digital Marketing Bootcamp',
      'subtitle': 'Grow your brand online',
      'level': 'Intermediate',
      'category': 'Marketing',
      'rating': '4.7',
    },
    {
      'title': 'Python for Data Science',
      'subtitle': 'Analyze data with Python',
      'level': 'Advanced',
      'category': 'Tech',
      'rating': '4.9',
    },
  ];

  void _onTabTapped(int index) {
    if (index == 1) {
      setState(() => _selectedIndex = 1);
      Navigator.push(
        context,
        AppTheme.slideRoute(const ProgramListScreen()),
      ).then((_) => setState(() => _selectedIndex = 0));
    } else if (index == 2) {
      setState(() => _selectedIndex = 2);
      Navigator.push(
        context,
        AppTheme.slideRoute(const DashboardScreen()),
      ).then((_) => setState(() => _selectedIndex = 0));
    }
  }

  String get _greeting {
    final name = UserSession.instance.name;
    return name.isNotEmpty ? 'Hi, ${name.split(' ').first} 👋' : 'Hi, Learner 👋';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // ── Gradient App Bar / Banner ──────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).padding.top + 20, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top row: logo + notification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'SkillPath',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('No new notifications'),
                                duration: Duration(seconds: 1)),
                          );
                        },
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.notifications_outlined,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Greeting
                  Text(
                    _greeting,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'What do you want to learn today?',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Search bar
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      AppTheme.slideRoute(const ProgramListScreen()),
                    ),
                    child: Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded,
                              color: AppTheme.textMuted, size: 20),
                          const SizedBox(width: 10),
                          Text('Search programs, skills...',
                              style: TextStyle(
                                  color: AppTheme.textMuted.withOpacity(0.8),
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // ── Categories ──────────────────────────────
                const Text('Explore Categories', style: AppTheme.h3),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _categories.map((cat) {
                    final color = AppTheme.categoryColor(cat['label'] as String);
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        AppTheme.slideRoute(const ProgramListScreen()),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(cat['icon'] as IconData,
                                color: color, size: 30),
                          ),
                          const SizedBox(height: 8),
                          Text(cat['label'] as String,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.textPrimary)),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 32),

                // ── Featured Programs ───────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Featured Programs', style: AppTheme.h3),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        AppTheme.slideRoute(const ProgramListScreen()),
                      ),
                      child: const Text('See all',
                          style: TextStyle(
                              color: AppTheme.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
              ]),
            ),
          ),

          // Horizontal scrolling program cards
          SliverToBoxAdapter(
            child: SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _featured.length,
                itemBuilder: (context, index) {
                  final p = _featured[index];
                  final color = AppTheme.categoryColor(p['category']!);
                  final levelColor = AppTheme.levelColor(p['level']!);
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      AppTheme.slideRoute(const ProgramListScreen()),
                    ),
                    child: Container(
                      width: 190,
                      margin: const EdgeInsets.only(right: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: AppTheme.cardShadow,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Thumbnail
                          Container(
                            height: 108,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  color.withOpacity(0.85),
                                  AppTheme.dark.withOpacity(0.9),
                                ],
                              ),
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    AppTheme.categoryIcon(p['category']!),
                                    size: 42,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: levelColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      p['level']!,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p['title']!,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  p['subtitle']!,
                                  style: AppTheme.bodySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(Icons.star_rounded,
                                        color: Color(0xFFFFC107), size: 13),
                                    const SizedBox(width: 3),
                                    Text(p['rating']!,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textPrimary)),
                                  ],
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
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),

          // ── Stats Banner ─────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppTheme.darkGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statItem('8+', 'Programs'),
                    _divider(),
                    _statItem('4', 'Categories'),
                    _divider(),
                    _statItem('1K+', 'Learners'),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),

      // ── Bottom Navigation ─────────────────────────────────
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTabTapped,
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Programs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7), fontSize: 12)),
      ],
    );
  }

  Widget _divider() {
    return Container(height: 36, width: 1, color: Colors.white24);
  }
}
