import 'package:flutter/material.dart';
import 'package:money_manager/custom_widgets/register/custom_snackbar.dart';
import 'package:money_manager/screens/login.dart';
import 'package:money_manager/service/user_service.dart';
import 'package:flutter/gestures.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _registerusername = TextEditingController();
  final TextEditingController _registerpassword = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();

  Future<void> check() async {
    if (_confirmpassword.text == _registerpassword.text &&
        _registerpassword.text.length >= 6 &&
        _confirmpassword.text.length >= 6 &&
        !_registerusername.text.contains(' ') &&
        !_registerpassword.text.contains(' ')) {
      String? result = await UserService.registerUser(
        _registerusername.text,
        _registerpassword.text,
      );
      if (!mounted) return;
      if (result == null) {
        showSnackBar(
          context,
          text: 'Successfully Registered',
          color: const Color.fromARGB(255, 57, 134, 60),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (route) => false,
        );
      } else {
        showSnackBar(context, text: result, color: Colors.red);
      }
    } else if (_registerpassword.text.length < 6 ||
        _confirmpassword.text.length < 6) {
      if (!mounted) return;
      showSnackBar(
        context,
        text: 'Password must more than 6 characters',
        color: Colors.red,
      );
    } else {
      if (!mounted) return;
      showSnackBar(context, text: "Don't match password", color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/signup.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            width: 290,
            height: 355,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 14, 14, 14),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: Colors.yellow),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                children: [
                  TextField(
                    controller: _registerusername,
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
                  SizedBox(height: 18),
                  TextField(
                    obscureText: true,
                    controller: _registerpassword,
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
                  SizedBox(height: 18),
                  TextField(
                    obscureText: true,
                    controller: _confirmpassword,
                    decoration: InputDecoration(
                      hint: Text(
                        'Confirm password',
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
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 1,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        children: [
                          const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.yellow,
                            ),
                          ),
                          TextSpan(
                            text: "Login here",
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
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          check();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow,
                      ),
                      child: Text(
                        "REGISTER",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
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
