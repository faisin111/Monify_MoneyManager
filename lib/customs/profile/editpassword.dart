import 'package:flutter/material.dart';
import 'package:money_manager/services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPass extends StatelessWidget {
  const EditPass({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController editpassController = TextEditingController();

    Future<void> editPassword() async {
      final prefs = await SharedPreferences.getInstance();
      if (editpassController.text.length >= 6 &&
          !editpassController.text.contains(' ')) {
        String? uid = await prefs.getString('current_uid');
        if (uid == null) return;
        await UserService.updateUser(uid, password: editpassController.text);
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Successfully updated",
              style: TextStyle(
                fontSize: 19,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 57, 134, 60),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      } else if (editpassController.text.length < 6) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password must more than 6 characters",
              style: TextStyle(
                fontSize: 19,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "password contain space",
              style: TextStyle(
                fontSize: 19,
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }
    }

    return AlertDialog(
      title: Center(
        child: Text(
          "Edit Password",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.yellow),
        ),
      ),
      content: Container(
        height: 60,
        child: TextField(
          controller: editpassController,
          decoration: InputDecoration(
            hint: Text(
              'enter password',
              style: TextStyle(color: const Color.fromARGB(255, 152, 152, 152)),
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 56, 56, 56),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),

      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(backgroundColor: Colors.yellow),
          child: Text(
            "cancel",
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            editPassword();
            Navigator.pop(context);
          },

          style: TextButton.styleFrom(backgroundColor: Colors.yellow),
          child: Text(
            "Update",
            style: TextStyle(
              fontSize: 15,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ],
    );
  }
}
