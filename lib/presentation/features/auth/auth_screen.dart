import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            spacing: 8,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(keyboardType: TextInputType.emailAddress),
              TextField(obscureText: true),
            ],
          ),
        ),
      ),
    );
  }
}
