import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:money_manager/customs/home/expence.dart';
import 'package:money_manager/customs/home/progile_icon.dart';
import 'package:money_manager/customs/home/salary.dart';
import 'package:money_manager/customs/profile/appinfo.dart';
import 'package:money_manager/customs/register/custom_snackbar.dart';
import 'package:money_manager/riverpodservice/expenseprovider.dart';
import 'package:money_manager/riverpodservice/incomeprovider.dart';
import 'package:money_manager/screens/login.dart';
import 'package:money_manager/services/image_services.dart';
import 'package:money_manager/services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final imageService = ImageService();
  File? _imageFile;
  String? id;
  String name = '';
  List<String> _name = [];
  String first = '';
  Future<void> acsess() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    _imageFile = imageService.loadImage(uid);
    setState(() {
      name = prefs.getString('username') ?? 'User';
      id = uid;
      _name = name.split('');
      _name[0] = _name[0].toUpperCase();
      first = _name.join('');
    });

  }

  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    bool success = await UserService.deleteAccount(uid);
    if (!mounted) return;
    if (success) {
      showSnackBar(
        context,
        text: "Account Deleted",
        color: const Color.fromARGB(255, 57, 134, 60),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
    } else {
      showSnackBar(context, text: "Error", color: Colors.red);
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  @override
  void initState() {
    super.initState();
    acsess();
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final expensetotal = ref.watch(totalExpenseFromState(id));
    final incomeTotal = ref.watch(totalIncome(id));
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/drawerimage.png'),
                  fit: BoxFit.fill,
                ),
                color: Colors.orange,
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.orange,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : null,
                    child: _imageFile == null
                        ? Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 38,
                          )
                        : null,
                  ),
                  Text(
                    'Welcome $first',
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              width: 200,
              height: 700,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/drawersource.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      size: 30,
                      color: const Color.fromARGB(255, 126, 126, 126),
                    ),
                    title: Text(
                      'App Info',
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppInfo()),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red, size: 30),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    onTap: () {
                      logOut();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.black, size: 30),
                    title: Text(
                      'Delete account',
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    onTap: () {
                      deleteAccount();
                    },
                  ),
                  Divider(color: Colors.yellow, height: 1),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.yellow),
        backgroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 85),
          child: Text(
            "Home",
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
          CustomprofileIcon(textfirst: first),
          Salary(),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            height: 435,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 46, 46, 46),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(60),
                topStart: Radius.circular(60),
              ),
            ),
            child: ListView(
              children: [
                Expence(
                  iconss: Icons.savings,
                  tittle: 'Savings',
                  trailing:
                      '\$${incomeTotal - expensetotal <= 0 ? 0.0 : incomeTotal - expensetotal}',
                  colortral: const Color.fromARGB(255, 54, 108, 244),
                ),
                Expence(
                  iconss: Icons.money,
                  tittle: 'Income',
                  trailing: '\$$incomeTotal',
                  colortral: Colors.green,
                ),
                Expence(
                  iconss: Icons.card_travel,
                  tittle: 'Expense',
                  trailing: '\$$expensetotal',
                  colortral: const Color.fromARGB(255, 222, 71, 104),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
