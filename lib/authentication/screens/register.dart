import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:tenfoldlit_mobile/authentication/screens/login.dart';

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
    bool passToggle = false;

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          backgroundColor: Colors.brown.shade50,
            appBar: AppBar(
                title: Center(child: const Text('TenfoldLit')),
                backgroundColor: Color.fromARGB(255, 149, 116, 81),
                foregroundColor: Colors.white,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: 700,
                    color: const Color.fromARGB(255, 255, 240, 204),
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                                'Register Your Account',
                                style: TextStyle(
                                  fontSize: 20
                                ),
                              ),
                              const SizedBox(height: 30,),
                              TextField(
                                  controller: _usernameController,
                                  cursorColor: Colors.brown,
                                  decoration: InputDecoration(
                                      labelText: 'Username',
                                      hintText: 'Username',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.brown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                      ),
                                      prefixIcon: const Icon(Icons.account_circle_outlined, color: Colors.black, size: 18,),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.brown.shade200, width: 2),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.brown.shade600, width: 1.5),
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                              ),
                              const SizedBox(height: 20,),
                              TextField(
                                  controller: _emailController,
                                  cursorColor: Colors.brown,
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      hintText: 'Email',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.brown,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400
                                      ),
                                      prefixIcon: const Icon(Icons.email_outlined, color: Colors.black, size: 18,),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.brown.shade200, width: 2),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.brown.shade600, width: 1.5),
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                              ),
                              const SizedBox(height: 20,),
                              TextField(
                                  controller: _passwordController,
                                  cursorColor: Colors.brown,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.brown,
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
                                        borderSide: BorderSide(color: Colors.brown.shade200, width: 2),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.brown.shade600, width: 1.5),
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                  obscureText: !passToggle,
                              ),
                              const SizedBox(height: 20,),
                              TextField(
                                  controller: _passwordConfirmationController,
                                  cursorColor: Colors.brown,
                                  decoration: InputDecoration(
                                      labelText: 'Password Confirmation',
                                      hintText: 'Confirm Password',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14
                                      ),
                                      labelStyle: const TextStyle(
                                        color: Colors.brown,
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
                                        borderSide: BorderSide(color: Colors.brown.shade200, width: 2),
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      floatingLabelStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.brown.shade600, width: 1.5),
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                  obscureText: !passToggle,
                              ),
                              const SizedBox(height: 30,),
                              MaterialButton(
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
                                      final response = await request.post("https://tenfoldlit-a10-tk.pbp.cs.ui.ac.id/register/", {
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
                                  height: 45,
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                  shape: RoundedRectangleBorder(
              
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  color: Color.fromARGB(255, 154, 118, 80),
                                  child: const Text('Register', style: TextStyle(color: Colors.white),),
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account?", style: TextStyle(color: Colors.grey.shade600, fontSize: 15),),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginPage()),
                                      );
                                    },
                                    child: const Text(
                                      'Login', style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                      ),
                    ),
                ),
              ),
            ),
        );
    }
}