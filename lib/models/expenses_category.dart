import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'expenses_category.g.dart';

@HiveType(typeId: 0)
@immutable
class Expensescategory {
  @HiveField(0)
  final String catogary;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String amount;
  @HiveField(3)
  final String? id;
  const Expensescategory({
    required this.catogary,
    required this.date,
    required this.amount,
    required this.id,
  });
}
