import 'package:flutter/material.dart';
import 'package:money_manager/screens/add.dart';
import 'package:money_manager/screens/calendar.dart';
import 'package:money_manager/screens/flowchart.dart';
import 'package:money_manager/screens/home.dart';
import 'package:money_manager/screens/profile.dart';

class BottomApp extends StatefulWidget {
  const BottomApp({super.key});

  @override
  State<BottomApp> createState() => _BottomAppState();
}

class _BottomAppState extends State<BottomApp> {
  int _selectIndex = 0;
  List<Widget> bottom = [Home(), FlowChart(), Add(), Calendar(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 199, 142, 8),
              borderRadius: BorderRadius.circular(50),
            ),

            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              currentIndex: _selectIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              onTap: (int index) {
                setState(() {
                  _selectIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, color: Colors.black),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pie_chart, color: Colors.black),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 31,
                      weight: 250,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month, color: Colors.black),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person, color: Colors.black),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),

      body: bottom[_selectIndex],
    );
  }
}
