import 'package:flutter/material.dart';
import 'package:money_manager/custom_widgets/add/expenses.dart';
import 'package:money_manager/custom_widgets/add/income.dart';
import 'package:money_manager/custom_widgets/add/savings.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Add",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.w900,
                fontSize: 35,
              ),
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.yellow,
            indicatorWeight: 5,
            labelColor: Colors.yellow,
            unselectedLabelColor: const Color.fromARGB(179, 255, 255, 255),
            labelStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: "Expense"),
              Tab(text: "Income"),
              Tab(text: "Balance"),
            ],
          ),
        ),
        body: TabBarView(children: [Expenses(), Income(), Savings()]),
      ),
    );
  }
}
