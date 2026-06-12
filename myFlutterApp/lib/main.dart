import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/history_provider.dart';
import 'providers/quiz_provider.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/register_screen.dart';
import 'screens/result_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/submission_detail_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MindCheckApp());
}

class MindCheckApp extends StatelessWidget {
  const MindCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: MaterialApp(
        title: 'MindCheck',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (ctx) => const SplashScreen(),
          '/login': (ctx) => const LoginScreen(),
          '/register': (ctx) => const RegisterScreen(),
          '/home': (ctx) => const HomeScreen(),
          '/quiz': (ctx) => const QuizScreen(),
          '/result': (ctx) => const ResultScreen(),
          '/history': (ctx) => const HistoryScreen(),
          '/submission-detail': (ctx) => const SubmissionDetailScreen(),
        },
      ),
    );
  }
}
