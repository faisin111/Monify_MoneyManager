import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'income_category.g.dart';

@HiveType(typeId: 1)
@immutable
class Incomecategory {
  @HiveField(0)
  final String category;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String amount;
  @HiveField(3)
  final String? id;
  const Incomecategory({
    required this.category,
    required this.date,
    required this.amount,
    required this.id,
  });
}
