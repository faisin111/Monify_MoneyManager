import 'package:hive/hive.dart';
part 'incomecategory.g.dart';
@HiveType(typeId: 1)
class Incomecategory {
  @HiveField(0)
  String category;
  @HiveField(1)
  String date;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String? id;
  Incomecategory({
    required this.category,
    required this.date,
    required this.amount,
    required this.id
  });
}
