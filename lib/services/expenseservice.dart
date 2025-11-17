import 'package:hive/hive.dart';
import 'package:money_manager/models/expensescategory.dart';

class Expenseservice {
  Box<Expensescategory>? _expencebox;
  Future<void> openBox() async {
    _expencebox = Hive.box<Expensescategory>('expenses_box');
  }

  Box<Expensescategory> get _box {
    _expencebox ??= Hive.box<Expensescategory>('expenses_box');
    return _expencebox!;
  }

  Future<void> addExpense(Expensescategory expenses) async {
    await _box.add(expenses);
  }

  Future<List<Expensescategory>> getExpense(String? uuid) async {
    return _box.values.where((u) => u.id == uuid).toList();
  }

  Future<double> getTotalExpence(String uuid) async {
    final list = _box.values.where((u) => u.id == uuid).toList();
    double total = 0.0;
    for (var u in list) {
      total += double.tryParse(u.amount) ?? 0.0;
    }
    return total;
  }

  Future<void> deleteExpense(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> updateExpense(int index, Expensescategory expense) async {
    await openBox();
    if (_expencebox == null) return;
    if (index < 0 || index >= _expencebox!.length) return;

    await _expencebox!.putAt(index, expense);
  }
}
