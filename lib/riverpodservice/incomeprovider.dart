import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/incomecategory.dart';
import 'package:state_notifier/state_notifier.dart';

final incomeBox = Provider<Box<Incomecategory>>((ref) {
  return Hive.box<Incomecategory>('income_box');
});

final filterIncome = Provider.family<List<Incomecategory>, String?>((
  ref,
  uuid,
) {
  final all = ref.watch(incomeProvider);
  if (uuid == null) return [];
  return all.where((u) => u.id == uuid).toList();
});

final totalIncome = Provider.family<double, String?>((ref, uuid) {
  final income = ref.watch(filterIncome(uuid));
  double t = 0.0;
  for (var u in income) {
    t += double.tryParse(u.amount) ?? 0.0;
  }
  return t;
});

final incomeProvider =
    StateNotifierProvider<IncomeNotifier, List<Incomecategory>>((ref) {
      final box = ref.watch(incomeBox);
      return IncomeNotifier(box);
    });

class IncomeNotifier extends StateNotifier<List<Incomecategory>> {
  final Box<Incomecategory>? box;
  IncomeNotifier(this.box) : super(box!.values.toList());

  Future<void> addIncome(Incomecategory income) async {
    await box!.add(income);
    state = box!.values.toList();
  }

  Future<void> deleteIncome(int index) async {
    await box!.deleteAt(index);
    state = box!.values.toList();
  }

  Future<void> updateExpense(int index, Incomecategory income) async {
    await box!.putAt(index, income);
    state = box!.values.toList();
  }

   Future<List<Incomecategory>> getExpense(String? uuid) async {
    return state = box!.values.where((u) => u.id == uuid).toList();
  }
}
