import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 2)
class UserModel{
  @HiveField(0)
  String uid;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;
  UserModel({required this.uid,required this.username,required this.password});
}