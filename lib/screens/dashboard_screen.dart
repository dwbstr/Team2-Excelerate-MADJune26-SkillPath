import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/program.dart';
import '../services/user_session.dart';
import 'program_list_screen.dart';
import 'program_detail_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  UserSession get _session => UserSession.instance;

  List<Program> get _enrolled => _session.enrolledPrograms;

  String get _initials {
    final name = _session.name;
    if (name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Log Out',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
            'Are you sure you want to log out? Your enrolled programs will be saved.',
            style: AppTheme.body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel',
                style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await _session.logout();
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        AppTheme.slideRoute(const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Profile'),
        actions: [
          TextButton.icon(
            onPressed: _handleLogout,
            icon: const Icon(Icons.logout_rounded,
                color: AppTheme.errorColor, size: 18),
            label: const Text('Logout',
                style: TextStyle(
                    color: AppTheme.errorColor, fontSize: 13)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Profile Header ───────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(28)),
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(44),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5), width: 3),
                    ),
                    child: Center(
                      child: Text(
                        _initials,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _session.name.isNotEmpty
                        ? _session.name
                        : 'Learner',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _session.email.isNotEmpty
                        ? _session.email
                        : 'No email set',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _statChip('${_enrolled.length}', 'Enrolled'),
                      _vDivider(),
                      _statChip('0', 'Completed'),
                      _vDivider(),
                      _statChip(
                          _enrolled.isNotEmpty ? '1' : '0', 'In Progress'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // ── Enrolled Programs ────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Programs (${_enrolled.length})',
                        style: AppTheme.h3,
                      ),
                      if (_enrolled.isNotEmpty)
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            AppTheme.slideRoute(const ProgramListScreen()),
                          ),
                          child: const Text('Browse more',
                              style: TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  if (_enrolled.isEmpty) ...[
                    _buildEmptyEnrolled(),
                  ] else ...[
                    ..._enrolled.map((p) => _EnrolledProgramCard(
                          program: p,
                          onTap: () => Navigator.push(
                            context,
                            AppTheme.slideRoute(
                                ProgramDetailScreen(program: p)),
                          ),
                        )),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyEnrolled() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        children: [
          const Icon(Icons.school_outlined,
              size: 48, color: AppTheme.textMuted),
          const SizedBox(height: 12),
          const Text('No programs yet', style: AppTheme.h3),
          const SizedBox(height: 6),
          const Text(
            'Explore our programs and enroll to start learning.',
            textAlign: TextAlign.center,
            style: AppTheme.body,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              AppTheme.slideRoute(const ProgramListScreen()),
            ),
            style: AppTheme.primaryButton(),
            child: const Text('Browse Programs'),
          ),
        ],
      ),
    );
  }

  Widget _statChip(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(
                color: Colors.white.withOpacity(0.75), fontSize: 12)),
      ],
    );
  }

  Widget _vDivider() {
    return Container(height: 38, width: 1, color: Colors.white24);
  }
}

class _EnrolledProgramCard extends StatelessWidget {
  final Program program;
  final VoidCallback onTap;

  const _EnrolledProgramCard({required this.program, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final catColor = AppTheme.categoryColor(program.category);
    final levelColor = AppTheme.levelColor(program.level);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppTheme.softShadow,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    catColor.withOpacity(0.85),
                    AppTheme.dark.withOpacity(0.8)
                  ],
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(AppTheme.categoryIcon(program.category),
                  color: Colors.white.withOpacity(0.9), size: 26),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(program.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppTheme.textPrimary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: levelColor.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(program.level,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: levelColor)),
                      ),
                      const SizedBox(width: 8),
                      Text(program.duration,
                          style: AppTheme.bodySmall
                              .copyWith(fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Progress bar (simulated)
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.1,
                            backgroundColor:
                                AppTheme.borderColor,
                            color: AppTheme.primary,
                            minHeight: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('10%',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primary)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.beginnerColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: AppTheme.beginnerColor, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
