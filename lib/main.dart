import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/login_screen.dart';
import 'services/user_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load persisted user data before the first frame is drawn
  await UserSession.instance.init();
  runApp(const SkillPathApp());
}

class SkillPathApp extends StatelessWidget {
  const SkillPathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillPath',
      theme: AppTheme.theme,
      home: const LoginScreen(),
    );
  }
}
