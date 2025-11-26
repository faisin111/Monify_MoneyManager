import 'package:money_manager/riverpodservice/expenseprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/expensescategory.dart';

class ExpenseDialog extends ConsumerStatefulWidget {
  final int index;
  final Expensescategory expense;
  const ExpenseDialog({super.key, required this.index, required this.expense});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExpenseDialogState();
}

class _ExpenseDialogState extends ConsumerState<ExpenseDialog> {
  String? currentId;
  late TextEditingController categoryController;
  late TextEditingController dateController;
  late TextEditingController amountController;

  Future<void> getId() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('current_uid');
    setState(() {
      currentId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    categoryController = TextEditingController(text: widget.expense.catogary);
    dateController = TextEditingController(text: widget.expense.date);
    amountController = TextEditingController(text: widget.expense.amount);
    getId();
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
    if (currentId == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
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
              id: currentId,
            );

            await ref
                .read(expenseProvider.notifier)
                .updateExpense(widget.index, updatedExpense);
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
