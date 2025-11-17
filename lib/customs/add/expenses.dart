import 'package:flutter/material.dart';
import 'package:money_manager/customs/add/expensedialogs/updateexpense.dart';
import 'package:money_manager/models/expensescategory.dart';
import 'package:money_manager/services/expenseservice.dart';
import 'package:money_manager/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final TextEditingController _catogary = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final Expenseservice _expenceservices = Expenseservice();
  List<Expensescategory> _expenses = [];
  String? currentId;
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('current_uid');
    _expenses = await _expenceservices.getExpense(id);
    globalExpenseNotifier.value = await _expenceservices.getExpense(id);
    if (!mounted) return;
    setState(() {
      currentId = id;
    });
  }

  Future<void> _initialize() async {
    await _expenceservices.openBox();
    await _load();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _expenses.length,
            itemBuilder: (context, index) {
              final expensee = _expenses[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1, color: Colors.yellow),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: ListTile(
                        leading: Icon(
                          Icons.arrow_downward,
                          size: 30,
                          color: Colors.red,
                        ),
                        title: Text(
                          "${expensee.catogary}",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          expensee.date,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                final result = await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return ExpenseDialog(
                                      index: index,
                                      expense: expensee,
                                    );
                                  },
                                );

                                if (result == true) {
                                  await _load();
                                }
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await _expenceservices.deleteExpense(index);
                                _load();
                              },
                              icon: Icon(Icons.delete, color: Colors.grey),
                            ),
                            Text(
                              "\$${double.tryParse(expensee.amount)?.toStringAsFixed(2) ?? '0.00'}",
                              style: TextStyle(fontSize: 17, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 130,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                addShowAlert();
              },
              backgroundColor: Colors.grey,
              child: Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
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
              "Add Expense",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.yellow,
              ),
            ),
          ),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: _catogary,
                  decoration: InputDecoration(
                    hint: Text(
                      'Catogary',
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
                SizedBox(height: 15),
                TextField(
                  controller: _date,
                  decoration: InputDecoration(
                    hint: Text(
                      'Date',
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
                SizedBox(height: 15),
                TextField(
                  controller: _amount,
                  decoration: InputDecoration(
                    hint: Text(
                      'Amount',
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
              ],
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
              onPressed: () {
                final newExpense = Expensescategory(
                  catogary: _catogary.text,
                  date: _date.text,
                  amount: _amount.text,
                  id: currentId,
                );
                _expenceservices.addExpense(newExpense);
                _catogary.clear();
                _date.clear();
                _amount.clear();
                if (!context.mounted) return;
                Navigator.pop(context);
                _load();
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
