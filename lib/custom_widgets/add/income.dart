import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager/custom_widgets/add/income_dialogs/update_income.dart';
import 'package:money_manager/models/income_category.dart';
import 'package:money_manager/providers/income_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Income extends ConsumerStatefulWidget {
  const Income({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IncomeState();
}

class _IncomeState extends ConsumerState<Income> {
  String? currentId;
  double superr = 0;
  final TextEditingController _catogary = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  Future<void> _loadd() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('current_uid');
    setState(() {
      currentId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadd();
  }

  @override
  Widget build(BuildContext context) {
    if (currentId == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final income = ref.watch(filterIncome(currentId));
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: income.length,
            itemBuilder: (context, index) {
              final incomesss = income[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 110,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 1, color: Colors.yellow),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: ListTile(
                        leading: const Icon(
                          Icons.arrow_upward,
                          size: 30,
                          color: Colors.green,
                        ),
                        title: Text(
                          incomesss.category,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          incomesss.date,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (_) => IncomeDialog(
                                    index: index,
                                    income: incomesss,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                ref
                                    .read(incomeProvider.notifier)
                                    .deleteIncomeNotifier(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "\$+${double.parse(incomesss.amount)}",
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 130,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                addShowAlert();
              },
              backgroundColor: Colors.grey,
              child: const Icon(Icons.add, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addShowAlert() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Add Income",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.yellow,
              ),
            ),
          ),
          content: Container(
            height: 200,
            child: Column(
              children: [
                TextField(
                  controller: _catogary,
                  decoration: InputDecoration(
                    hint: Text(
                      'Catogary',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 152, 152, 152),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 56, 56, 56),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _date,
                  decoration: InputDecoration(
                    hint: Text(
                      'Date',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 152, 152, 152),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 56, 56, 56),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: _amount,
                  decoration: InputDecoration(
                    hint: Text(
                      'Amount',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 152, 152, 152),
                      ),
                    ),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 56, 56, 56),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.yellow),
              child: Text(
                "cancel",
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final newIncome = Incomecategory(
                  category: _catogary.text,
                  date: _date.text,
                  amount: _amount.text == '' ? '0' : _amount.text,
                  id: currentId,
                );
                ref.read(incomeProvider.notifier).addIncomeNotifier(newIncome);
                _catogary.clear();
                _date.clear();
                _amount.clear();
                if (!context.mounted) return;
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(backgroundColor: Colors.yellow),
              child: Text(
                "add",
                style: TextStyle(
                  fontSize: 15,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
