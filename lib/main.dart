import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'auth_wrapper.dart';
import 'views/landing_view.dart';
import 'views/login_view.dart';
import 'views/signup_view.dart';
import 'views/home_view.dart';

// Uygulama ilk kez açıldı mı kontrolü için key
const String firstLaunchKey = 'isFirstLaunch';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // İlk açılış kontrolü
  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool(firstLaunchKey) ?? true;

  runApp(MyApp(isFirstLaunch: isFirstLaunch));

  // İlk açılıştan sonra değeri false yap
  if (isFirstLaunch) {
    await prefs.setBool(firstLaunchKey, false);
  }
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({super.key, required this.isFirstLaunch});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YEĞİTEK TODO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: isFirstLaunch ? const LandingView() : const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignUpView(),
        '/home': (context) => const HomeView(),
      },
    );
  }
}
