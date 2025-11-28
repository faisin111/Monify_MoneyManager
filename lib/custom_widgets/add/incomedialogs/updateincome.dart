import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager/providers/income_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/incomecategory.dart';

import 'package:flutter/material.dart';

class IncomeDialog extends ConsumerStatefulWidget {
  final int index;
  final Incomecategory income;

  const IncomeDialog({super.key, required this.index, required this.income});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IncomeDialogState();
}

class _IncomeDialogState extends ConsumerState<IncomeDialog> {
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

    categoryController = TextEditingController(text: widget.income.category);
    dateController = TextEditingController(text: widget.income.date);
    amountController = TextEditingController(text: widget.income.amount);
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
            final updatedIncome = Incomecategory(
              category: categoryController.text,
              date: dateController.text,
              amount: amountController.text,
              id: currentId,
            );
            await ref
                .read(incomeProvider.notifier)
                .updateIncomeNotifier(widget.index, updatedIncome);

            if (!context.mounted) return;
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
