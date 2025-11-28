import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager/custom_widgets/flow_chart/graph.dart';
import 'package:money_manager/providers/expense_providers.dart';
import 'package:money_manager/providers/income_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlowChart extends ConsumerStatefulWidget {
  const FlowChart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FlowchartState();
}

class _FlowchartState extends ConsumerState<FlowChart> {
  String? id;

  Future<void> get() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    setState(() {
      id = uid;
    });
  }

  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final expensetotal = ref.watch(totalFilteredExpense(id));
    final incometotal = ref.watch(totalFilteredIncome(id));
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Graph",
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.w900,
              fontSize: 35,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 400, child: Graph()),
          Container(
            width: 300,
            height: 250,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 54, 108, 244),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Savings',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  '\$${incometotal - expensetotal <= 0 ? 0.0 : incometotal - expensetotal}',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Text('Your savings is now', style: TextStyle(fontSize: 25)),
                Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Income',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 222, 71, 104),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      'Expense',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
