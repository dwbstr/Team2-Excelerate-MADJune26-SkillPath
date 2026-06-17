import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/program.dart';

class ProgramService {
  Future<List<Program>> fetchPrograms() async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));
    
    try {
      final String response = await rootBundle.loadString('assets/programs.json');
      final List<dynamic> data = json.decode(response);
      return data.map((json) => Program.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load programs: $e');
    }
  }
}
