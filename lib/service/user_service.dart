import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserService {
  static final userBox = Hive.box<UserModel>('user');

  static Future<void> updateUser(
    String uid, {
    String? name,
    String? password,
  }) async {
    UserModel? user = userBox.get(uid);

    if (user == null) return;

    if (name != null) user.username = name;
    if (password != null) user.password = password;

    await userBox.put(uid, user);
  }

  static Future<bool> deleteAccount(String? uid) async {
    try {
      await userBox.delete(uid);

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove("current_uid");

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> registerUser(String username, String password) async {
    for (var user in userBox.values) {
      if (user.username == username && user.password == password) {
        return 'User already exist';
      }
    }
    final uid = const Uuid().v4();
    UserModel newUser = UserModel(
      uid: uid,
      username: username,
      password: password,
    );
    await userBox.put(uid, newUser);
    return null;
  }

  static Future<UserModel?> loginUser(String username, String password) async {
    for (var user in userBox.values) {
      if (user.username == username && user.password == password) {
        return user;
      }
    }
    return null;
  }
}
