import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_manager/custom_widgets/register/custom_snackbar.dart';
import 'package:money_manager/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logOut(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLogin', false);
  if (!context.mounted) return;
  showSnackBar(
    context,
    text: "Logout confirmed",
    color: const Color.fromARGB(255, 57, 134, 60),
  );
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => Login()),
  );
}
