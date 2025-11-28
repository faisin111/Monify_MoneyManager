import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/models/expenses_category.dart';
import 'package:money_manager/models/income_category.dart';
import 'package:money_manager/models/user_model.dart';
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
  runApp(ProviderScope(child: const MyApp()));
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
