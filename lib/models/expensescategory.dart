import 'package:hive/hive.dart';
part 'expensescategory.g.dart'; 
@HiveType(typeId: 0)
class Expensescategory {
  @HiveField(0)
  String catogary;
  @HiveField(1)
  String date;
  @HiveField(2)
  String amount;
  @HiveField(3)
  String? id;
  Expensescategory({
    required this.catogary,
    required this.date,
    required this.amount,
    required this.id
  });
}
