import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager/providers/expense_providers.dart';
import 'package:money_manager/providers/income_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Graph extends ConsumerStatefulWidget {
  const Graph({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GraphState();
}

class _GraphState extends ConsumerState<Graph> {
  String? currentid;
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    setState(() {
      currentid = uid;
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    if (currentid == null) {
      return Center(child: CircularProgressIndicator());
    }
    final expensetotal = ref.watch(totalFilteredExpense(currentid));
    final incomeTotal = ref.watch(totalFilteredIncome(currentid));
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: const Color.fromARGB(255, 54, 108, 244),
            radius: 50,
            value: incomeTotal - expensetotal <= 0
                ? 1
                : incomeTotal - expensetotal,
          ),
          PieChartSectionData(
            color: const Color.fromARGB(255, 222, 71, 104),
            radius: 50,
            value: expensetotal <= 0 ? 1 : expensetotal,
          ),
          PieChartSectionData(
            color: Colors.green,
            radius: 50,
            value: incomeTotal <= 0 ? 1 : incomeTotal,
          ),
        ],
        centerSpaceRadius: 70,
        sectionsSpace: 2,
      ),
    );
  }
}
