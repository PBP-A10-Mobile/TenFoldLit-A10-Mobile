import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/authentication/screens/register.dart';
import 'package:tenfoldlit_mobile/homepage/screens/menu.dart';

void main() {
    runApp(const LoginApp());
}

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
          title: 'Login',
          theme: ThemeData(
              primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
      );
      }
}

class LoginPage extends StatefulWidget {
    const LoginPage({super.key});

    @override
    _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool passToggle = false;

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          backgroundColor: Colors.brown.shade50,
            appBar: AppBar(
                title: Center(child: const Text('TenfoldLit')),
                backgroundColor: Colors.brown.shade400,
                foregroundColor: Colors.white,
            ),
            body: SafeArea(
              child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                            const SizedBox(height: 30,),
                            TextField(
                                controller: _usernameController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    labelText: 'Username',
                                    hintText: 'Username',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    ),
                                    prefixIcon: const Icon(Icons.account_circle_outlined, color: Colors.black, size: 18,),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                            ),
                            const SizedBox(height: 12.0),
                            TextField(
                                controller: _passwordController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Password',
                                    hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                    labelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                    ),
                                    prefixIcon: const Icon(Icons.key_rounded, color: Colors.black, size: 18,),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passToggle = !passToggle;
                                        });
                                      },
                                      child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade400, width: 2),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    floatingLabelStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                                      borderRadius: BorderRadius.circular(10)
                                    )
                                ),
                                obscureText: !passToggle,
                            ),
                            const SizedBox(height: 30.0),
                            MaterialButton(
                                onPressed: () async {
                                    String username = _usernameController.text;
                                    String password = _passwordController.text;
                              
                                    // Cek kredensial
                                    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                    // Untuk menyambungkan Android emulator dengan Django pada localhost,
                                    // gunakan URL http://10.0.2.2/
                                    final response = await request.login("http://127.0.0.1:8000/login_flutter/", {
                                    'username': username,
                                    'password': password,
                                    });
                        
                                    if (request.loggedIn) {
                                        String message = response['message'];
                                        String uname = response['username'];
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => HomePage()),
                                        );
                                        ScaffoldMessenger.of(context)
                                            ..hideCurrentSnackBar()
                                            ..showSnackBar(
                                                SnackBar(content: Text("$message Selamat datang, $uname.")));
                                        } else {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                title: const Text('Login Gagal'),
                                                content:
                                                    Text(response['message']),
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
                                height: 45,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                shape: RoundedRectangleBorder(

                                  borderRadius: BorderRadius.circular(10)
                                ),
                                color: Colors.brown,
                                child: const Text('Login', style: TextStyle(color: Colors.white),),
                            ),
                            const SizedBox(height: 15.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account yet?", style: TextStyle(color: Colors.grey.shade600, fontSize: 14),),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegisterPage()),
                                    );
                                  },
                                  child: const Text(
                                    "Register here",
                                  ),
                                ),
                              ],
                            ),
                        ],
                    ),
                  ),
              ),
            ),
        );
    }
}