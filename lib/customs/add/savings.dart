import 'package:flutter/material.dart';
import 'package:money_manager/customs/add/customlisttile.dart';
import 'package:money_manager/riverpodservice/incomeprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:money_manager/riverpodservice/expenseprovider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Savings extends ConsumerStatefulWidget {
  const Savings({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavingsState();
}

class _SavingsState extends ConsumerState<Savings> {
  String? id;
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    setState(() {
      id = uid;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final expensetotal = ref.watch(totalExpenseFromState(id));
    final incomeTotal = ref.watch(totalIncome(id));
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 50),
                      child: Container(
                        width: 320,
                        height: 300,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 48, 48, 48),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 1, color: Colors.yellow),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                values: "\$$incomeTotal",
                              ),
                              CustomListtile(
                                leading: 'Expense',
                                values: "\$$expensetotal",
                              ),
                              Divider(color: Colors.yellow),
                              CustomListtile(
                                leading: 'Savings',
                                values: '\$${incomeTotal-expensetotal<=0?0.0:incomeTotal-expensetotal}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
