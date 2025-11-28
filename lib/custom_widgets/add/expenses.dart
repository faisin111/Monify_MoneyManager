import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager/custom_widgets/add/expense_dialogs/update_expense.dart';
import 'package:money_manager/models/expenses_category.dart';
import 'package:money_manager/providers/expense_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Expenses extends ConsumerStatefulWidget {
  const Expenses({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpensesState();
}

class _ExpensesState extends ConsumerState<Expenses> {
  final TextEditingController _catogary = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  String? currentId;
  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('current_uid');
    setState(() {
      currentId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    if (currentId == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final expenseget = ref.watch(filteredExpenses(currentId));
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: expenseget.length,
            itemBuilder: (context, index) {
              final expensee = expenseget[index];
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
                            fontSize: 22,
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
                                await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return ExpenseDialog(
                                      index: index,
                                      expense: expensee,
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                await ref
                                    .read(expenseProvider.notifier)
                                    .deleteExpenseNotifier(index);
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
                ref
                    .read(expenseProvider.notifier)
                    .addExpenseNotifier(newExpense);
                _catogary.clear();
                _date.clear();
                _amount.clear();
                if (!context.mounted) return;
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
