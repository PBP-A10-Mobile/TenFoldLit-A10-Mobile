import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/authentication/login.dart';
import 'package:tenfoldlit_mobile/homepage/screens/menu.dart';

void main() {
    runApp(const RegisterApp());
}

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'Register',
          theme: ThemeData(
              primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
      );
      }
}

class RegisterPage extends StatefulWidget {
    const RegisterPage({super.key});

    @override
    _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _passwordConfirmationController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
            appBar: AppBar(
                title: const Text('Register'),
            ),
            body: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        TextField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                                labelText: 'Username',
                            ),
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                            ),
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                            ),
                            obscureText: true,
                        ),
                        const SizedBox(height: 12.0),
                        TextField(
                            controller: _passwordConfirmationController,
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                            ),
                            obscureText: true,
                        ),
                        const SizedBox(height: 24.0),
                        ElevatedButton(
                            onPressed: () async {
                                String username = _usernameController.text;
                                String password = _passwordController.text;
                                String passwordConfirmation = _passwordConfirmationController.text;
                                String email = _emailController.text;

                                if (password != passwordConfirmation) {
                                  ScaffoldMessenger.of(context)
                                        ..hideCurrentSnackBar()
                                        ..showSnackBar(
                                            SnackBar(content: Text("Register gagal, field password tidak sama.")));
                                  return;
                                }
                                // Cek kredensial
                                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                // gunakan URL http://10.0.2.2/
                                final response = await request.post("http://127.0.0.1:8000/register/", {
                                'username': username,
                                'password': password,
                                'email' : email,
                                });

                                if (response['status']) {
                                  String message = response['message'];

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                  );
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Register Gagal'),
                                      content: Text(response['message']),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            },
                            child: const Text('Register'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: const Text(
                            'Already have an account? Login',
                          ),
                        ),
                    ],
                ),
            ),
        );
    }
}