import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manager/customs/register/custom_snackbar.dart';
import 'package:money_manager/screens/bottomnav.dart';
import 'package:money_manager/screens/register.dart';
import 'package:money_manager/services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    var user = await UserService.loginUser(_username.text, _password.text);
    if (user == null) {
      showSnackBar(
        context,
        text: 'Invalid username and password',
        color: Colors.red,
      );
      return;
    }
    showSnackBar(
      context,
      text: "Successfully login",
      color: const Color.fromARGB(255, 57, 134, 60),
    );
    prefs.setString('username', _username.text);
    prefs.setString('registerpassword', _password.text);
    prefs.setBool('isLogin', true);
    prefs.setString('current_uid', user.uid);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomApp()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/login.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            width: 290,
            height: 300,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 14, 14, 14),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: Colors.yellow),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _username,
                    decoration: InputDecoration(
                      hint: Text(
                        'Username',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 152, 152, 152),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 56, 56, 56),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 27),
                  TextField(
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                      hint: Text(
                        'Password',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 152, 152, 152),
                        ),
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 56, 56, 56),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        children: [
                          const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 11,
                            ),
                          ),
                          TextSpan(
                            text: "Register here",
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Register(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        loginCheck();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    child: Text(
                      "LOG IN",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 17,
                      ),
                    ),
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
