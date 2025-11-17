import 'package:flutter/material.dart';
import 'package:money_manager/models/expensescategory.dart';
import 'package:money_manager/models/incomecategory.dart';

ValueNotifier<List<Incomecategory>> globalIncomeNotifier = ValueNotifier([]);
ValueNotifier<List<Expensescategory>> globalExpenseNotifier = ValueNotifier([]);
ValueNotifier<double> incomenotifier = ValueNotifier(0);
ValueNotifier<double> expensesnotifier = ValueNotifier(0);
