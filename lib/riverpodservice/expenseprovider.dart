import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/expensescategory.dart';
import 'package:state_notifier/state_notifier.dart';


final filteredExpenses = Provider.family<List<Expensescategory>, String?>((ref, uuid) {
  final all = ref.watch(expenseProvider);
  if (uuid == null) return [];
  return all.where((e) => e.id == uuid).toList();
});

final totalExpenseFromState = Provider.family<double, String?>((ref, uuid) {
  final list = ref.watch(filteredExpenses(uuid));
  double total = 0.0;
  for (var u in list) {
    total += double.tryParse(u.amount) ?? 0.0;
  }
  return total;
});



final expenceBox = Provider<Box<Expensescategory>>((ref) {
  return Hive.box<Expensescategory>("expenses_box");
});

final expenseProvider =
    StateNotifierProvider<CategoryNotifier, List<Expensescategory>>((ref) {
      final box = ref.watch(expenceBox);
      return CategoryNotifier(box);
    });

class CategoryNotifier extends StateNotifier<List<Expensescategory>> {
  final Box<Expensescategory>? box;
  CategoryNotifier(this.box) : super(box!.values.toList());

  Future<void> addExpense(Expensescategory expenses) async {
    await box!.add(expenses);
    state = box!.values.toList();
  }

  Future<List<Expensescategory>> getExpense(String? uuid) async {
    return state = box!.values.where((u) => u.id == uuid).toList();
  }

  
  Future<void> deleteExpense(int index) async {
    await box!.deleteAt(index);
    state = box!.values.toList();
  }

  Future<void> updateExpense(int index, Expensescategory expense) async {
    await box!.putAt(index, expense);
    state = box!.values.toList();
  }
}
