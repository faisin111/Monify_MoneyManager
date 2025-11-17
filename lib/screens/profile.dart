import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:money_manager/customs/profile/appinfo.dart';
import 'package:money_manager/customs/profile/customtile.dart';
import 'package:money_manager/customs/profile/editname.dart';
import 'package:money_manager/customs/profile/editpassword.dart';
import 'package:money_manager/customs/register/custom_snackbar.dart';
import 'package:money_manager/screens/login.dart';
import 'package:money_manager/services/image_services.dart';
import 'package:money_manager/services/userservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final imageService = ImageService();
  String? id;
  File? _imageFile;
  String name = '';
  List<String> _name = [];
  String first = '';
  Future<void> ass() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
     _imageFile = imageService.loadImage(uid);
    setState(() {
      id = uid;
      name = prefs.getString('username') ?? 'User';
      _name = name.split('');
      _name[0] = _name[0].toUpperCase();
      first = _name.join('');
    });
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogin', false);
    if(!mounted)return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  Future<void> deleteAccount() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('current_uid');
    bool success = await UserService.deleteAccount(uid);
    if(!mounted)return;
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

  @override
  void initState() {
    super.initState();
    ass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.yellow,
              fontWeight: FontWeight.w900,
              fontSize: 35,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 45),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.orange,
                child: ClipOval(
                  child: Container(
                    width: 200,
                    height: 200,
                    color: Colors.orange,
                    child: _imageFile == null
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 80,
                          )
                        : Image.file(_imageFile!, fit: BoxFit.cover),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    first,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 535,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 46, 46, 46),
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(60),
                    topStart: Radius.circular(60),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/profile.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40,
                  ),
                  child: ListView(
                    children: [
                      Customtile(
                        text: "UserName",
                        trailing: IconButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (_) {
                                return EditName();
                              },
                            );
                            await ass();
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),

                      Divider(color: const Color.fromARGB(255, 113, 113, 113)),
                      Customtile(
                        text: "Password",
                        trailing: IconButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (_) {
                                return EditPass();
                              },
                            );
                          },
                          icon: Icon(Icons.edit),
                        ),
                      ),
                      Divider(color: const Color.fromARGB(255, 113, 113, 113)),
                      Customtile(text: "Profile Dp",trailing: IconButton(onPressed: ()async{
                      final result= await imageService.deleteImage(id);
                      if(!context.mounted)return;
                      if(result==false){
                        showSnackBar(context, text: "Profile dp is null",color: Colors.red);
                      }else{
                       showSnackBar(context, text: "Successfully deleted",color:  const Color.fromARGB(255, 57, 134, 60));
                       await ass();}
                      }, icon: Icon(Icons.delete)),),
                      Divider(color: const Color.fromARGB(255, 113, 113, 113)),
                      ListTile(
                        leading: Text(
                          "App Info",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AppInfo()),
                          );
                        },
                      ),
                      Divider(color: const Color.fromARGB(255, 113, 113, 113)),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 17,
                          vertical: 35,
                        ),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  deleteAccount();
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.black,
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              icon: Icon(Icons.delete),
                              label: Text('Delete Account'),
                            ),
                            SizedBox(width: 20),
                            TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  logOut();
                                });
                              },
                              icon: Icon(Icons.logout),
                              label: Text("Logout"),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.red,
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 130,
            right: 108,
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 40,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              onPressed: () async {
                final result = await imageService.pickImage(id);
                if(!context.mounted)return;
                if (result == null) {
                  showSnackBar(context, text: "Error", color: Colors.red);
                } else {
                  showSnackBar(
                    context,
                    text: "Successfully Added",
                    color:  const Color.fromARGB(255, 57, 134, 60),
                  );
                  await ass();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
