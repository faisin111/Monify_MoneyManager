import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/controller/income_controller.dart';
import 'package:money_manager/models/incomecategory.dart';

final incomeBox = Provider<Box<Incomecategory>>((ref) {
  return Hive.box<Incomecategory>('income_box');
});

final incomeProvider =
    StateNotifierProvider<IncomeController, List<Incomecategory>>((ref) {
      final box = ref.watch(incomeBox);
      return IncomeController(box);
    });

final filterIncome = Provider.family<List<Incomecategory>, String?>((
  ref,
  uuid,
) {
  final all = ref.watch(incomeProvider);
  if (uuid == null) return [];
  return all.where((u) => u.id == uuid).toList();
});

final totalFilteredIncome = Provider.family<double, String?>((ref, uuid) {
  final income = ref.watch(filterIncome(uuid));
  double t = 0.0;
  for (var u in income) {
    t += double.tryParse(u.amount) ?? 0.0;
  }
  return t;
});
