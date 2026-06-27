import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;
    bool isValid = true;

    if (email.isEmpty || !email.contains('@') || !email.contains('.')) {
      setState(() => _emailError = 'Please enter a valid email address');
      isValid = false;
    }
    if (password.isEmpty) {
      setState(() => _passwordError = 'Password cannot be empty');
      isValid = false;
    } else if (password.length < 6) {
      setState(() => _passwordError = 'Password must be at least 6 characters');
      isValid = false;
    }

    if (!isValid) return;

    setState(() => _isLoading = true);
    // Simulate authentication delay
    await Future.delayed(const Duration(milliseconds: 900));
    if (!mounted) return;
    setState(() => _isLoading = false);

    Navigator.pushReplacement(
      context,
      AppTheme.slideRoute(const HomeScreen()),
    );
  }

  void _showForgotPasswordDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Reset Password',
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter your email and we\'ll send a reset link.',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              decoration: AppTheme.inputDecoration(
                label: 'Email',
                icon: Icons.email_outlined,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel',
                style: TextStyle(color: AppTheme.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Reset link sent! Check your email.'),
                  backgroundColor: AppTheme.beginnerColor,
                ),
              );
            },
            style: AppTheme.primaryButton(),
            child: const Text('Send Link'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ── Gradient Header ──────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(28, 48, 28, 36),
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(Icons.school_rounded,
                          size: 44, color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'SkillPath',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Learn. Grow. Succeed.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.8),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Form ─────────────────────────────────────────
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Welcome back', style: AppTheme.h2),
                    const SizedBox(height: 4),
                    const Text('Login to continue your learning journey.',
                        style: AppTheme.body),
                    const SizedBox(height: 28),

                    // Email
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppTheme.inputDecoration(
                        label: 'Email',
                        icon: Icons.email_outlined,
                        hint: 'you@example.com',
                      ).copyWith(errorText: _emailError),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: AppTheme.inputDecoration(
                        label: 'Password',
                        icon: Icons.lock_outline_rounded,
                        hint: '••••••••',
                        suffix: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: AppTheme.textSecondary,
                            size: 20,
                          ),
                          onPressed: () =>
                              setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ).copyWith(errorText: _passwordError),
                    ),

                    // Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _showForgotPasswordDialog,
                        child: const Text('Forgot Password?',
                            style: TextStyle(
                                color: AppTheme.primary, fontSize: 13)),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: AppTheme.darkButton(),
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
                            : const Text('Login'),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(color: AppTheme.borderColor)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('or continue with',
                              style: AppTheme.bodySmall
                                  .copyWith(fontSize: 12)),
                        ),
                        const Expanded(
                            child: Divider(color: AppTheme.borderColor)),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Google button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Google Sign-In coming soon!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Text('G',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4285F4))),
                        label: const Text('Continue with Google',
                            style: TextStyle(
                                color: AppTheme.textPrimary, fontSize: 14)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppTheme.borderColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ",
                            style: TextStyle(
                                color: AppTheme.textSecondary, fontSize: 14)),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            AppTheme.slideRoute(const SignUpScreen()),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
