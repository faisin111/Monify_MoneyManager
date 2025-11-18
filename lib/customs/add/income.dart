import 'package:flutter/material.dart';
import 'package:money_manager/customs/add/incomedialogs/updateincome.dart';
import 'package:money_manager/models/incomecategory.dart';
import 'package:money_manager/global.dart';
import 'package:money_manager/services/incomeservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Income extends StatefulWidget {
  const Income({super.key});

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  String? currentId;
  double superr = 0;
  final TextEditingController _catogary = TextEditingController();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final Incomeservice _incomeservicee = Incomeservice();
  List<Incomecategory> incomes = [];
  Future<void> _loadd() async {
    final prefs = await SharedPreferences.getInstance();
    String? id = prefs.getString('current_uid');
    incomes = await _incomeservicee.getincome(id);
    if (!mounted) return;
    setState(() {
      currentId = id;
    });
  }

  Future<void> _initialize() async {
    await _incomeservicee.openBox();
    await _loadd();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView.builder(
            itemCount: incomes.length,
            itemBuilder: (context, index) {
              final incomesss = incomes[index];
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
                                final result = await showDialog(
                                  context: context,
                                  builder: (_) => IncomeDialog(
                                    index: index,
                                    income: incomesss,
                                  ),
                                );
                                if (result == true) {
                                  await _loadd();
                                }
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                _incomeservicee.deleteIncome(index);

                                _loadd();
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
                  amount: _amount.text==''?'0':_amount.text,
                  id: currentId,
                );
                _incomeservicee.addIncome(newIncome);
                _catogary.clear();
                _date.clear();
                _amount.clear();
                if (!context.mounted) return;
                Navigator.pop(context);
                _loadd();
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
