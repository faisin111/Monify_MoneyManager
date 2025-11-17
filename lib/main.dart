import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/expensescategory.dart';
import 'package:money_manager/models/incomecategory.dart';
import 'package:money_manager/models/usermodel.dart';
import 'package:money_manager/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpensescategoryAdapter());
  await Hive.openBox<Expensescategory>('expenses_box');
  Hive.registerAdapter(IncomecategoryAdapter());
  await Hive.openBox<Incomecategory>('income_box');

  await Hive.openBox('salary');
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>('user');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      theme: ThemeData.dark(),
    );
  }
}
