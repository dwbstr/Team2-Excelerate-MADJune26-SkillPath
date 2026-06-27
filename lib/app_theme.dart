import 'package:flutter/material.dart';

class AppTheme {
  // ── Colors ──────────────────────────────────────────────────
  static const Color primary = Color(0xFF4A90D9);
  static const Color primaryDark = Color(0xFF3A7BC8);
  static const Color dark = Color(0xFF4A4A6A);
  static const Color background = Color(0xFFF5F7FA);
  static const Color surface = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A2E);
  static const Color textSecondary = Color(0xFF666680);
  static const Color textMuted = Color(0xFFBBBBBB);
  static const Color borderColor = Color(0xFFEEEEEE);
  static const Color errorColor = Color(0xFFFF3B30);

  // ── Level Colors ────────────────────────────────────────────
  static const Color beginnerColor = Color(0xFF34C759);
  static const Color intermediateColor = Color(0xFFFF9500);
  static const Color advancedColor = Color(0xFFFF3B30);

  static Color levelColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return beginnerColor;
      case 'intermediate':
        return intermediateColor;
      case 'advanced':
        return advancedColor;
      default:
        return primary;
    }
  }

  static Color levelBg(String level) => levelColor(level).withOpacity(0.12);

  // ── Category Colors & Icons ──────────────────────────────────
  static Color categoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'tech':
        return const Color(0xFF4A90D9);
      case 'design':
        return const Color(0xFFAF52DE);
      case 'business':
        return const Color(0xFF34C759);
      case 'marketing':
        return const Color(0xFFFF9500);
      default:
        return primary;
    }
  }

  static Color categoryBg(String category) =>
      categoryColor(category).withOpacity(0.12);

  static IconData categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'tech':
        return Icons.computer_rounded;
      case 'design':
        return Icons.brush_rounded;
      case 'business':
        return Icons.business_center_rounded;
      case 'marketing':
        return Icons.campaign_rounded;
      default:
        return Icons.school_rounded;
    }
  }

  // ── Gradients ────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A90D9), Color(0xFF5B6CE7)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A4A6A), Color(0xFF2D2D4E)],
  );

  static LinearGradient categoryGradient(String category) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          categoryColor(category),
          categoryColor(category).withOpacity(0.7),
          dark,
        ],
      );

  // ── Input Decoration ─────────────────────────────────────────
  static InputDecoration inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: textSecondary, size: 20),
      suffixIcon: suffix,
      labelStyle: const TextStyle(color: textSecondary, fontSize: 14),
      hintStyle: const TextStyle(color: textMuted, fontSize: 14),
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: errorColor, width: 1.5),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  // ── Text Styles ──────────────────────────────────────────────
  static const TextStyle h1 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: -0.3,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    letterSpacing: -0.2,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: textSecondary,
    height: 1.55,
  );
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: textSecondary,
    height: 1.4,
  );
  static const TextStyle label = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: textPrimary,
  );

  // ── Button Styles ────────────────────────────────────────────
  static ButtonStyle primaryButton({double radius = 12}) =>
      ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      );

  static ButtonStyle darkButton({double radius = 12}) =>
      ElevatedButton.styleFrom(
        backgroundColor: dark,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        textStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      );

  // ── Card Shadows ─────────────────────────────────────────────
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ];

  // ── Page Route ───────────────────────────────────────────────
  static Route<T> slideRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 280),
    );
  }

  // ── ThemeData ────────────────────────────────────────────────
  static ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: surface,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.2,
          ),
          iconTheme: IconThemeData(color: textPrimary),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: surface,
          selectedItemColor: primary,
          unselectedItemColor: textMuted,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          unselectedLabelStyle: TextStyle(fontSize: 11),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: primaryButton(),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: borderColor),
          ),
        ),
      );
}
