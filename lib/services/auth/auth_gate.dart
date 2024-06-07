import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:typengame/services/auth/login_or_register.dart';
import 'package:typengame/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //If user is logged in :
          if (snapshot.hasData) {
            return HomePage();
          }

          //If user is not logged in :
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
