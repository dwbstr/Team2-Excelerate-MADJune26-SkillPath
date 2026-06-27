import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/program.dart';
import '../services/user_session.dart';
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
  final _feedbackController = TextEditingController();
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

  bool get _isEnrolled =>
      UserSession.instance.isEnrolled(widget.program);

  @override
  Widget build(BuildContext context) {
    final program = widget.program;
    final catColor = AppTheme.categoryColor(program.category);
    final levelColor = AppTheme.levelColor(program.level);

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          program.category,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked
                  ? Icons.bookmark_rounded
                  : Icons.bookmark_border_rounded,
              color: _isBookmarked ? AppTheme.primary : AppTheme.textPrimary,
            ),
            onPressed: () {
              setState(() => _isBookmarked = !_isBookmarked);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      _isBookmarked ? 'Bookmarked!' : 'Bookmark removed'),
                  duration: const Duration(seconds: 1),
                ),
              );
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
                  // ── Gradient Hero ───────────────────────
                  Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          catColor,
                          catColor.withOpacity(0.75),
                          AppTheme.dark,
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Decorative circles
                        Positioned(
                          top: -30,
                          right: -30,
                          child: _decorCircle(130, 0.1),
                        ),
                        Positioned(
                          bottom: -40,
                          left: -20,
                          child: _decorCircle(160, 0.08),
                        ),
                        // Main icon
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                AppTheme.categoryIcon(program.category),
                                size: 64,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  program.category,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Level badge
                        Positioned(
                          bottom: 14,
                          left: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color: levelColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${program.level} friendly',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        // Enrolled badge
                        if (_isEnrolled)
                          Positioned(
                            bottom: 14,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppTheme.beginnerColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.check_circle_rounded,
                                      color: Colors.white, size: 14),
                                  SizedBox(width: 4),
                                  Text('Enrolled',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(program.title,
                            style: AppTheme.h1
                                .copyWith(fontSize: 22)),
                        const SizedBox(height: 10),

                        // Rating + duration row
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                color: Color(0xFFFFC107), size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '${program.rating}  •  ${program.reviews} reviews',
                              style: const TextStyle(
                                  fontSize: 13,
                                  color: AppTheme.textSecondary,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.access_time_rounded,
                                      size: 13, color: AppTheme.primary),
                                  const SizedBox(width: 4),
                                  Text(program.duration,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.primary,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // ── Tab Bar ────────────────────────
                        Container(
                          decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: AppTheme.borderColor)),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: AppTheme.primary,
                            unselectedLabelColor: AppTheme.textSecondary,
                            indicatorColor: AppTheme.primary,
                            indicatorWeight: 2.5,
                            labelStyle: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14),
                            unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                            tabs: const [
                              Tab(text: 'Overview'),
                              Tab(text: 'Instructor'),
                              Tab(text: 'Reviews'),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Tab Content ────────────────────
                        SizedBox(
                          height: 560,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _OverviewTab(program: program),
                              _InstructorTab(program: program),
                              _ReviewsTab(
                                program: program,
                                formKey: _formKey,
                                feedbackController: _feedbackController,
                                selectedRating: _selectedRating,
                                onRatingChanged: (r) =>
                                    setState(() => _selectedRating = r),
                                onSubmit: _submitFeedback,
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

          // ── Enroll Now / Already Enrolled ───────────────
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, -3),
                )
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: _isEnrolled
                  ? OutlinedButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.check_circle_rounded,
                          color: AppTheme.beginnerColor),
                      label: const Text('Already Enrolled',
                          style: TextStyle(
                              color: AppTheme.beginnerColor,
                              fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppTheme.beginnerColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        AppTheme.slideRoute(
                            RegistrationScreen(program: widget.program)),
                      ).then((_) => setState(() {})),
                      style: AppTheme.darkButton(),
                      child: const Text('Enroll Now'),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Review submitted successfully!'),
          backgroundColor: AppTheme.beginnerColor,
          duration: Duration(seconds: 2),
        ),
      );
      _feedbackController.clear();
      setState(() => _selectedRating = 5);
    }
  }

  Widget _decorCircle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(opacity),
      ),
    );
  }
}

// ── Overview Tab ──────────────────────────────────────────────
class _OverviewTab extends StatelessWidget {
  final Program program;
  const _OverviewTab({required this.program});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('About this program', style: AppTheme.h3),
          const SizedBox(height: 10),
          Text(program.description,
              style: AppTheme.body.copyWith(color: AppTheme.textSecondary)),
          const SizedBox(height: 24),
          _InfoRow(
            icon: Icons.access_time_rounded,
            label: 'Duration',
            value: program.duration,
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.signal_cellular_alt_rounded,
            label: 'Level',
            value: program.level,
            valueColor: AppTheme.levelColor(program.level),
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.workspace_premium_rounded,
            label: 'Certificate',
            value: 'Issued on completion',
          ),
          const SizedBox(height: 12),
          _InfoRow(
            icon: Icons.language_rounded,
            label: 'Language',
            value: 'English',
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppTheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: AppTheme.primary),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: AppTheme.bodySmall.copyWith(fontSize: 11)),
            Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Instructor Tab ────────────────────────────────────────────
class _InstructorTab extends StatelessWidget {
  final Program program;
  const _InstructorTab({required this.program});

  @override
  Widget build(BuildContext context) {
    final instructor = program.instructor;
    if (instructor == null) {
      return const Center(
          child: Text('No instructor info available.',
              style: AppTheme.body));
    }
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar with initials
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Center(
                  child: Text(
                    instructor.name.isNotEmpty
                        ? instructor.name[0].toUpperCase()
                        : 'I',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(instructor.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppTheme.textPrimary)),
                    const SizedBox(height: 2),
                    Text(instructor.title,
                        style: AppTheme.body.copyWith(fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('About', style: AppTheme.h3),
          const SizedBox(height: 8),
          Text(instructor.bio,
              style: AppTheme.body.copyWith(color: AppTheme.textSecondary)),
        ],
      ),
    );
  }
}

// ── Reviews Tab ───────────────────────────────────────────────
class _ReviewsTab extends StatelessWidget {
  final Program program;
  final GlobalKey<FormState> formKey;
  final TextEditingController feedbackController;
  final int selectedRating;
  final ValueChanged<int> onRatingChanged;
  final VoidCallback onSubmit;

  const _ReviewsTab({
    required this.program,
    required this.formKey,
    required this.feedbackController,
    required this.selectedRating,
    required this.onRatingChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Existing reviews
          if (program.reviewsList.isNotEmpty) ...[
            Text('${program.reviews} Reviews',
                style: AppTheme.h3),
            const SizedBox(height: 12),
            ...program.reviewsList
                .map((r) => _ReviewTile(review: r)),
            const SizedBox(height: 24),
          ],

          // Feedback form
          const Text('Leave a Review', style: AppTheme.h3),
          const SizedBox(height: 14),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Star rating selector
                const Text('Your Rating',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSecondary)),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (i) {
                    return GestureDetector(
                      onTap: () => onRatingChanged(i + 1),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.star_rounded,
                          size: 34,
                          color: i < selectedRating
                              ? const Color(0xFFFFC107)
                              : AppTheme.borderColor,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 14),
                // Feedback text
                TextFormField(
                  controller: feedbackController,
                  maxLines: 4,
                  decoration: AppTheme.inputDecoration(
                    label: 'Your Review',
                    icon: Icons.chat_bubble_outline_rounded,
                    hint: 'Share your experience with this program...',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) {
                      return 'Please write your feedback';
                    }
                    if (v.trim().length < 10) {
                      return 'Review must be at least 10 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onSubmit,
                    icon: const Icon(Icons.send_rounded, size: 18),
                    label: const Text('Submit Review'),
                    style: AppTheme.primaryButton(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final Review review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Avatar initials
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        review.name.isNotEmpty
                            ? review.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(review.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: AppTheme.textPrimary)),
                ],
              ),
              Row(
                children: List.generate(
                  review.stars,
                  (_) => const Icon(Icons.star_rounded,
                      color: Color(0xFFFFC107), size: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(review.comment,
              style: AppTheme.body.copyWith(fontSize: 13)),
        ],
      ),
    );
  }
}
