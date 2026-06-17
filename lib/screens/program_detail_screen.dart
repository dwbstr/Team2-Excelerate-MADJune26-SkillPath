import 'package:flutter/material.dart';
import '../models/program.dart';
import 'registration_screen.dart';

class ProgramDetailScreen extends StatefulWidget {
  final Program program;

  const ProgramDetailScreen({super.key, required this.program});

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBookmarked = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  int _selectedRating = 5;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _feedbackController.dispose();
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
                            '${program.level} friendly',
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
                          program.title,
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
                              '${program.rating} (${program.reviews} reviews)',
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
                          height: 320,
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
                                    program.description,
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
                                    program.duration,
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              program.instructor?.name ?? 'Unknown Instructor',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: Color(0xFF1A1A2E),
                                              ),
                                            ),
                                            Text(
                                              program.instructor?.title ?? '',
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF888888),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    program.instructor?.bio ?? '',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF555555),
                                      height: 1.6,
                                    ),
                                  ),
                                ],
                              ),

                              // Review tab
                              SingleChildScrollView(
                                padding: EdgeInsets.zero,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...program.reviewsList.map((r) => Padding(
                                      padding: const EdgeInsets.only(bottom: 12.0),
                                      child: _reviewTile(r.name, r.comment, r.stars),
                                    )),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Leave a Review',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1A1A2E),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: List.generate(5, (index) {
                                              return IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                icon: Icon(
                                                  Icons.star_rounded,
                                                  color: index < _selectedRating
                                                      ? const Color(0xFFFFC107)
                                                      : const Color(0xFFDDDDDD),
                                                  size: 28,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _selectedRating = index + 1;
                                                  });
                                                },
                                              );
                                            }),
                                          ),
                                          const SizedBox(height: 12),
                                          TextFormField(
                                            controller: _feedbackController,
                                            maxLines: 3,
                                            decoration: InputDecoration(
                                              hintText: 'Write your feedback here...',
                                              hintStyle: const TextStyle(fontSize: 13, color: Color(0xFFBBBBBB)),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: Color(0xFFEEEEEE)),
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.trim().isEmpty) {
                                                return 'Please enter your feedback';
                                              }
                                              return null;
                                            },
                                          ),
                                          const SizedBox(height: 12),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (_formKey.currentState!.validate()) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(content: Text('Feedback submitted successfully!')),
                                                  );
                                                  _feedbackController.clear();
                                                  setState(() {
                                                    _selectedRating = 5;
                                                  });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF4A90D9),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              child: const Text('Submit Review'),
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                        ],
                                      ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(
                        program: program,
                      ),
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
