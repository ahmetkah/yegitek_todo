import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Kullanıcı oturum açmışsa
        if (snapshot.hasData) {
          return const HomeView();
        }
        // Kullanıcı oturum açmamışsa
        return const LoginView();
      },
    );
  }
}
