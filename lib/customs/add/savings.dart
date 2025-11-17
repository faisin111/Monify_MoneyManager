import 'package:flutter/material.dart';
import 'package:money_manager/customs/add/customlisttile.dart';
import 'package:money_manager/global.dart';
import 'package:money_manager/services/expenseservice.dart';
import 'package:money_manager/services/incomeservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Savings extends StatefulWidget {
  const Savings({super.key});

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  final incomeservice = Incomeservice();
  final expenseservice = Expenseservice();
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    setState(() {});
    if (uid == null) return;
    await incomeservice.openBox();
    await expenseservice.openBox();
    double incometotal = await incomeservice.getAllIncome(uid);
    incomenotifier.value = incometotal;
    double expensetotal = await expenseservice.getTotalExpence(uid);
    expensesnotifier.value = expensetotal;
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: ValueListenableBuilder(
                  valueListenable: incomenotifier,
                  builder: (context, index, _) {
                    return ValueListenableBuilder(
                      valueListenable: expensesnotifier,
                      builder: (context, index, _) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 50),
                              child: Container(
                                width: 320,
                                height: 300,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 48, 48, 48),
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.yellow,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Balance Sheet',
                                        style: TextStyle(
                                          color: Colors.yellow,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27,
                                        ),
                                      ),
                                      CustomListtile(
                                        leading: 'Income',
                                        values: "\$${incomenotifier.value}",
                                      ),
                                      CustomListtile(
                                        leading: 'Expense',
                                        values: "\$${expensesnotifier.value}",
                                      ),
                                      Divider(color: Colors.yellow),
                                      CustomListtile(
                                        leading: 'Savings',
                                        values:
                                            "\$${incomenotifier.value - expensesnotifier.value <= 0 ? 0.0 : incomenotifier.value - expensesnotifier.value}",
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
