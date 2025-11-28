import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/expenses_category.dart';
import 'package:state_notifier/state_notifier.dart';

class ExpenseController extends StateNotifier<List<Expensescategory>> {
  Box<Expensescategory>? box;
  ExpenseController(this.box) : super(box!.values.toList());

  Future<void> addExpenseNotifier(Expensescategory expense) async {
    await box!.add(expense);
    state = box!.values.toList();
  }

  Future<void> updateExpenseNotifier(
    int index,
    Expensescategory expense,
  ) async {
    await box!.putAt(index, expense);
    state = box!.values.toList();
  }

  Future<void> deleteExpenseNotifier(int index) async {
    await box!.deleteAt(index);
    state = box!.values.toList();
  }
}
