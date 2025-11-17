import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/global.dart';
import 'package:money_manager/services/expenseservice.dart';
import 'package:money_manager/services/incomeservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  final incomeservice = Incomeservice();
  final expenseservice = Expenseservice();
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    setState(() {});
    if (uid == null) return;
    await incomeservice.openBox();
    await expenseservice.openBox();
    double incometotal = await incomeservice.getAllIncome(uid);
    incomenotifier.value = incometotal;
    double expensetotal = await expenseservice.getTotalExpence(uid);
    expensesnotifier.value = expensetotal;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: incomenotifier,
      builder: (context, index, _) {
        return ValueListenableBuilder(
          valueListenable: expensesnotifier,
          builder: (context, index, _) {
            return PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: const Color.fromARGB(255, 54, 108, 244),
                    radius: 50,
                    value: incomenotifier.value - expensesnotifier.value <= 0
                        ? 1
                        : incomenotifier.value - expensesnotifier.value,
                  ),
                  PieChartSectionData(
                    color: const Color.fromARGB(255, 222, 71, 104),
                    radius: 50,
                    value: expensesnotifier.value <= 0
                        ? 1
                        : expensesnotifier.value,
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    radius: 50,
                    value: incomenotifier.value <= 0 ? 1 : incomenotifier.value,
                  ),
                ],
                centerSpaceRadius: 70,
                sectionsSpace: 2,
              ),
            );
          },
        );
      },
    );
  }
}
