import 'package:flutter/material.dart';
import 'package:money_manager/customs/flowchart/graph.dart';
import 'package:money_manager/global.dart';

class FlowChart extends StatefulWidget {
  const FlowChart({super.key});

  @override
  State<FlowChart> createState() => _FlowChartState();
}

class _FlowChartState extends State<FlowChart> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ValueListenableBuilder(
        valueListenable: incomenotifier,
        builder: (context, index, _) {
          return Column(
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
                      '\$${incomenotifier.value - expensesnotifier.value <= 0 ? 0.0 : incomenotifier.value - expensesnotifier.value}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
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
          );
        },
      ),
    );
  }
}
