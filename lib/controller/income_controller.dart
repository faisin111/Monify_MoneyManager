import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/income_category.dart';
import 'package:state_notifier/state_notifier.dart';

class IncomeController extends StateNotifier<List<Incomecategory>> {
  final Box<Incomecategory>? box;
  IncomeController(this.box) : super(box!.values.toList());

  Future<void> addIncomeNotifier(Incomecategory income) async {
    await box!.add(income);
    state = box!.values.toList();
  }

  Future<void> updateIncomeNotifier(int index, Incomecategory income) async {
    await box!.putAt(index, income);
    state = box!.values.toList();
  }

  Future<void> deleteIncomeNotifier(int index) async {
    await box!.deleteAt(index);
    state = box!.values.toList();
  }
}
