import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/models/expensescategory.dart';
import '../../../services/expenseservice.dart';
import 'package:flutter/material.dart';

class ExpenseDialog extends StatefulWidget {
  final int index;
  final Expensescategory expense;

  const ExpenseDialog({super.key, required this.index, required this.expense});

  @override
  State<ExpenseDialog> createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends State<ExpenseDialog> {
  String? currentId;
  late TextEditingController categoryController;
  late TextEditingController dateController;
  late TextEditingController amountController;
  final Expenseservice _expenseservice = Expenseservice();

 Future<void> getId()async{
  final prefs=await SharedPreferences.getInstance();
  String? id=prefs.getString('current_uid');
  setState(() {
    currentId=id;
  });
 }

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.expense.catogary);
    dateController = TextEditingController(text: widget.expense.date);
    amountController = TextEditingController(text: widget.expense.amount);
  }

  @override
  void dispose() {
    categoryController.dispose();
    dateController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          "Update Income",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.yellow),
        ),
      ),
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hint: const Text(
                  'Category',
                  style: TextStyle(color: Color.fromARGB(255, 152, 152, 152)),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 56, 56, 56),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                hint: const Text(
                  'Date',
                  style: TextStyle(color: Color.fromARGB(255, 152, 152, 152)),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 56, 56, 56),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                hint: const Text(
                  'Amount',
                  style: TextStyle(color: Color.fromARGB(255, 152, 152, 152)),
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
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(backgroundColor: Colors.yellow),
          child: const Text(
            "cancel",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            final updatedExpense = Expensescategory(
              catogary: categoryController.text,
              date: dateController.text,
              amount: amountController.text,
              id: currentId
            );
                var expensese = await Hive.box('salary');
                expensese.put(
                  'expensese',
                  (double.tryParse(
                            expensese
                                .get('expensese', defaultValue: '0')
                                .toString(),
                          ) ??
                          0.0) +
                      (double.tryParse(amountController.text) ?? 0.0),
                );
            await _expenseservice.updateExpense(widget.index, updatedExpense);

            if (!mounted) return;
            Navigator.pop(context, true);
          },
          style: TextButton.styleFrom(backgroundColor: Colors.yellow),
          child: const Text(
            "update",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
