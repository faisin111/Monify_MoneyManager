import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Salary extends StatefulWidget {
  const Salary({super.key});

  @override
  State<Salary> createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
  double sal = 0;
  String? id;
  final TextEditingController _salary = TextEditingController();
  String logo = '';
  String _log = '';
  Future<void> acsess() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    logo = prefs.getString('username') ?? 'User';
    setState(() {
      id = uid;
      _log = logo[0].toUpperCase();
    });
  }

  Future<void> salary() async {
    var salary = await Hive.box('salary');
    salary.put(
      'yoursalary_$id',
      double.parse(_salary.text == '' ? "0" : _salary.text),
    );
  }

  Future<void> getSalary() async {
    var salary = await Hive.box('salary');
    setState(() {
      sal = salary.get('yoursalary_$id') ?? 0.0;
    });
    int sala = sal.toInt();
    _salary.text = sala.toString();
  }

  @override
  void initState() {
    acsess();
    getSalary();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
      child: Container(
        width: double.infinity,
        height: 149,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow, const Color.fromARGB(255, 199, 142, 8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 14,
              left: 25,
              child: Text(
                "Your Salary",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              top: 49,
              left: 25,
              child: Text(
                "\$$sal",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 99,
              left: 25,
              child: Text(
                "Balance",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 280,
              child: IconButton(
                onPressed: () {
                  addShowAlert();
                },
                icon: Icon(Icons.more_horiz, color: Colors.black, size: 33),
              ),
            ),
            Positioned(
              top: 82,
              left: 270,
              child: Text(
                _log,
                style: TextStyle(
                  color: Colors.yellow,
                  fontSize: 43,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addShowAlert() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Add Salary",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.yellow,
              ),
            ),
          ),
          content: Container(
            height: 60,
            child: TextField(
              controller: _salary,
              decoration: InputDecoration(
                hint: Text(
                  'salary',
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
                salary();

                getSalary();

                Navigator.pop(context);
              },

              style: TextButton.styleFrom(backgroundColor: Colors.yellow),
              child: Text(
                "add",
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
