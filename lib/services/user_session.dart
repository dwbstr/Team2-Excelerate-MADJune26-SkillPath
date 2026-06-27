import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/program.dart';

/// Singleton that persists user profile and enrolled programs via SharedPreferences.
/// Call [init] once at app startup before [runApp].
class UserSession {
  static final UserSession instance = UserSession._internal();
  UserSession._internal();

  static const _keyName = 'user_name';
  static const _keyEmail = 'user_email';
  static const _keyEnrolled = 'enrolled_programs';

  // In-memory state (loaded from prefs on init)
  String name = '';
  String email = '';
  List<Program> enrolledPrograms = [];
  List<Program> _allPrograms = [];

  bool get isLoggedIn => name.isNotEmpty;

  /// Load all programs from JSON and restore persisted user data.
  /// Must be awaited before [runApp].
  Future<void> init() async {
    // 1. Load all programs from the JSON asset
    try {
      final String response =
          await rootBundle.loadString('assets/programs.json');
      final List<dynamic> data = json.decode(response);
      _allPrograms = data.map((j) => Program.fromJson(j)).toList();
    } catch (_) {
      _allPrograms = [];
    }

    // 2. Restore user profile from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString(_keyName) ?? '';
    email = prefs.getString(_keyEmail) ?? '';

    // 3. Rebuild enrolled programs list by cross-referencing stored titles
    //    with the current programs.json data (data integration)
    final storedTitles = prefs.getStringList(_keyEnrolled) ?? [];
    enrolledPrograms = _allPrograms
        .where((p) => storedTitles.contains(p.title))
        .toList();
  }

  /// Save user profile to SharedPreferences.
  Future<void> saveUser({required String newName, required String newEmail}) async {
    name = newName;
    email = newEmail;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyName, newName);
    await prefs.setString(_keyEmail, newEmail);
  }

  /// Enroll in a program and persist the enrollment.
  Future<void> enroll(Program program) async {
    if (!isEnrolled(program)) {
      enrolledPrograms.add(program);
      final prefs = await SharedPreferences.getInstance();
      final titles = enrolledPrograms.map((p) => p.title).toList();
      await prefs.setStringList(_keyEnrolled, titles);
    }
  }

  /// Check if a program is already enrolled (reads from in-memory list).
  bool isEnrolled(Program program) {
    return enrolledPrograms.any((p) => p.title == program.title);
  }

  /// Clear all persisted data and reset in-memory state.
  Future<void> logout() async {
    name = '';
    email = '';
    enrolledPrograms = [];
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyName);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyEnrolled);
  }
}
