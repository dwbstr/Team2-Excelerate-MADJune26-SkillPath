import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/program.dart';
import '../services/user_session.dart';
import 'home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  final Program? program;

  const RegistrationScreen({super.key, this.program});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedLevel = 'Beginner';
  final List<String> _levels = ['Beginner', 'Intermediate', 'Advanced'];

  // Pre-fill if user already has session data
  @override
  void initState() {
    super.initState();
    final session = UserSession.instance;
    if (session.name.isNotEmpty) _nameController.text = session.name;
    if (session.email.isNotEmpty) _emailController.text = session.email;
    // Match level to program level if available
    if (widget.program != null &&
        _levels.contains(widget.program!.level)) {
      _selectedLevel = widget.program!.level;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    // Persist user profile
    await UserSession.instance.saveUser(
      newName: _nameController.text.trim(),
      newEmail: _emailController.text.trim(),
    );

    // Enroll in the program (persists to SharedPreferences)
    if (widget.program != null) {
      await UserSession.instance.enroll(widget.program!);
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    // Show success dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(28),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.beginnerColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(36),
              ),
              child: const Icon(Icons.check_circle_rounded,
                  color: AppTheme.beginnerColor, size: 44),
            ),
            const SizedBox(height: 16),
            const Text('Enrolled!',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary)),
            const SizedBox(height: 8),
            Text(
              'Welcome, ${_nameController.text.trim().split(' ').first}! '
              'You\'re now enrolled in ${widget.program?.title ?? 'the program'}.',
              textAlign: TextAlign.center,
              style: AppTheme.body,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: AppTheme.primaryButton(),
                child: const Text('Go to Home'),
              ),
            ),
          ],
        ),
      ),
    );

    if (!mounted) return;
    // Clear stack and go home
    Navigator.pushAndRemoveUntil(
      context,
      AppTheme.slideRoute(const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final programTitle = widget.program?.title ?? 'Program';

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Enrollment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Program Info Banner ──────────────────────
            if (widget.program != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: AppTheme.categoryGradient(
                      widget.program!.category),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        AppTheme.categoryIcon(widget.program!.category),
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            programTitle,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${widget.program!.duration}  •  ${widget.program!.level}',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            const Text('Your Details', style: AppTheme.h2),
            const SizedBox(height: 6),
            const Text(
              'Complete the form below to finalize your enrollment.',
              style: AppTheme.body,
            ),
            const SizedBox(height: 24),

            // ── Form ────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: AppTheme.softShadow,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Full Name
                    TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: AppTheme.inputDecoration(
                        label: 'Full Name',
                        icon: Icons.person_outline_rounded,
                        hint: 'Your full name',
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppTheme.inputDecoration(
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        hint: 'you@example.com',
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(v)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: AppTheme.inputDecoration(
                        label: 'Create Password',
                        icon: Icons.lock_outline_rounded,
                        hint: 'At least 6 characters',
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppTheme.textSecondary,
                            size: 20,
                          ),
                          onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Password is required';
                        }
                        if (v.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Experience Level dropdown
                    DropdownButtonFormField<String>(
                      initialValue: _selectedLevel,
                      decoration: AppTheme.inputDecoration(
                        label: 'Experience Level',
                        icon: Icons.signal_cellular_alt_rounded,
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down_rounded,
                          color: AppTheme.textSecondary),
                      items: _levels.map((level) {
                        return DropdownMenuItem<String>(
                          value: level,
                          child: Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: AppTheme.levelColor(level),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(level),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (v) =>
                          setState(() => _selectedLevel = v),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Select a level' : null,
                    ),
                    const SizedBox(height: 28),

                    // Submit
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submitForm,
                        style: AppTheme.primaryButton(),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text('Complete Enrollment'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
