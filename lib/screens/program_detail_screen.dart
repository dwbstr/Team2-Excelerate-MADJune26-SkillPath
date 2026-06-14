import 'package:flutter/material.dart';

class ProgramDetailScreen extends StatefulWidget {
  final Map<String, String> program;

  const ProgramDetailScreen({super.key, required this.program});

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final program = widget.program;

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
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              color: _isBookmarked
                  ? const Color(0xFF4A90D9)
                  : const Color(0xFF1A1A2E),
            ),
            onPressed: () {
              setState(() => _isBookmarked = !_isBookmarked);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero image with badge
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 220,
                        color: const Color(0xFFDDE6F5),
                        child: const Center(
                          child: Icon(
                            Icons.play_circle_fill_rounded,
                            size: 64,
                            color: Color(0xFF4A90D9),
                          ),
                        ),
                      ),
                      // Level badge
                      Positioned(
                        bottom: 14,
                        left: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${program['level'] ?? 'Beginner'} friendly',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          program['title'] ?? 'Program',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Rating row
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFFFC107), size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${program['rating'] ?? '4.6'} (${program['reviews'] ?? '100'} reviews)',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF555555),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Tabs: Overview / Instructor / Review
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFFEEEEEE)),
                            ),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: const Color(0xFF4A90D9),
                            unselectedLabelColor: const Color(0xFF888888),
                            indicatorColor: const Color(0xFF4A90D9),
                            indicatorWeight: 2.5,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            tabs: const [
                              Tab(text: 'Overview'),
                              Tab(text: 'Instructor'),
                              Tab(text: 'Review'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Tab content
                        SizedBox(
                          height: 220,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              // Overview tab
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'About this program',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1A1A2E),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    program['description'] ??
                                        'This program is designed for learners who want to build real skills and grow professionally.',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF555555),
                                      height: 1.6,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // Duration & Certification
                                  _infoRow(
                                    Icons.access_time_rounded,
                                    'Duration',
                                    program['duration'] ?? '4 weeks',
                                  ),
                                  const SizedBox(height: 12),
                                  _infoRow(
                                    Icons.workspace_premium_rounded,
                                    'Certification',
                                    'Yes',
                                  ),
                                ],
                              ),

                              // Instructor tab
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDDE6F5),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: const Icon(
                                          Icons.person_rounded,
                                          size: 32,
                                          color: Color(0xFF4A90D9),
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'John Smith',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color(0xFF1A1A2E),
                                            ),
                                          ),
                                          Text(
                                            'Senior Developer & Trainer',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF888888),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  const Text(
                                    'John has over 8 years of experience in mobile and web development. He has trained 1000+ learners across 20+ countries and is passionate about making tech education accessible.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF555555),
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),

                              // Review tab
                              Column(
                                children: [
                                  _reviewTile('Aisha K.',
                                      'Really loved this course! Very practical and easy to follow.', 5),
                                  const SizedBox(height: 12),
                                  _reviewTile('Marcus T.',
                                      'Great content. Would recommend to anyone starting out.', 4),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Enroll Now button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Enrolled in ${program['title'] ?? 'program'}!'),
                      backgroundColor: const Color(0xFF4A90D9),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A4A6A),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Enroll Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F0FE),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF4A90D9)),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF888888),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _reviewTile(String name, String comment, int stars) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              Row(
                children: List.generate(
                  stars,
                  (_) => const Icon(Icons.star_rounded,
                      color: Color(0xFFFFC107), size: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            comment,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF555555),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}