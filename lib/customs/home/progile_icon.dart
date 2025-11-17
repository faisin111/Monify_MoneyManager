import 'dart:io';

import 'package:flutter/material.dart';
import 'package:money_manager/services/image_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomprofileIcon extends StatefulWidget {
  final String textfirst;
  const CustomprofileIcon({super.key, required this.textfirst});

  @override
  State<CustomprofileIcon> createState() => _CustomprofileIconState();
}

class _CustomprofileIconState extends State<CustomprofileIcon> {
  final imageService = ImageService();
  File? _imageFile;
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    _imageFile = await imageService.loadImage(uid);
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 19, 19, 19),
          borderRadius: BorderRadius.circular(39),
          border: Border.all(width: 2, color: Colors.yellow),
        ),
        child: Center(
          child: ListTile(
            leading: CircleAvatar(
              radius: 39,
              backgroundColor: Colors.orange,
              backgroundImage: _imageFile != null
                  ? FileImage(_imageFile!)
                  : null,
              child: _imageFile == null
                  ? const Icon(Icons.person, color: Colors.white, size: 35)
                  : null,
            ),

            title: Text(
              "Good Morning",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            subtitle: Text(
              widget.textfirst,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
