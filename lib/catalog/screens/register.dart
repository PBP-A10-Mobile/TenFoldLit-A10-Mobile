import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/auth/register/'),
      body: {
        'username': usernameController.text,
        'password': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Registration successful
      // Navigate to login screen or perform other actions
      print('Registration successful');
    } else {
      // Registration failed
      // Handle the error
      print('Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
