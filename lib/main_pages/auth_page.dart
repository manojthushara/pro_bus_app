import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro_bus_app/pages/mainpages/home_page.dart';
import 'package:pro_bus_app/main_pages/login_or_register_page.dart';

import 'navigator_bar.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logging in
          if (snapshot.hasData) {
            return NavigationPage();
          } else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
