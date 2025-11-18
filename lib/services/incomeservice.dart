import 'package:hive/hive.dart';
import 'package:money_manager/models/incomecategory.dart';

class Incomeservice {
  Box<Incomecategory>? _incomeBox;
  Future<void> openBox() async {
    _incomeBox = Hive.box<Incomecategory>('income_box');
  }

  Future<void> addIncome(Incomecategory income) async {
    await _incomeBox!.add(income);
  }

  Future<List<Incomecategory>> getincome(String? uuid) async {
    return _incomeBox!.values.where((u) => u.id == uuid).toList();
  }

  Future<double> getAllIncome(String? uuid) async {
    final list = _incomeBox!.values.where((u) => u.id == uuid).toList();
    double total = 0.0;
    for (var u in list) {
      total += double.tryParse(u.amount) ?? 0.0;
    }
    return total;
  }

  Future<void> deleteIncome(int index) async {
    await _incomeBox!.deleteAt(index);
  }

  Future<void> updateIncome(int index, Incomecategory incomee) async {
    await openBox();
    if (_incomeBox == null) return;
    if (index < 0 || index >= _incomeBox!.length) return;

    await _incomeBox!.putAt(index, incomee);
  }
}
