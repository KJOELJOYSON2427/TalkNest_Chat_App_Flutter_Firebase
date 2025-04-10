import 'package:flutter/material.dart';
import 'package:my_project/Pages/Auth/Widget/AuthPageBody.dart';
import 'package:my_project/Pages/Welcome/widget/WelcomeHeading.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WelcomeHeading(),
                SizedBox(height: 20),
                Authpagebody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
