import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/controller/expense_controller.dart';
import 'package:money_manager/models/expenses_category.dart';

final expenceBox = Provider<Box<Expensescategory>>((ref) {
  return Hive.box<Expensescategory>("expenses_box");
});

final expenseProvider =
    StateNotifierProvider<ExpenseController, List<Expensescategory>>((ref) {
      final box = ref.watch(expenceBox);
      return ExpenseController(box);
    });

final filteredExpenses = Provider.family<List<Expensescategory>, String?>((
  ref,
  uuid,
) {
  final all = ref.watch(expenseProvider);
  if (uuid == null) return [];
  return all.where((e) => e.id == uuid).toList();
});

final totalFilteredExpense = Provider.family<double, String?>((ref, uuid) {
  final list = ref.watch(filteredExpenses(uuid));
  double total = 0.0;
  for (var u in list) {
    total += double.tryParse(u.amount) ?? 0.0;
  }
  return total;
});
