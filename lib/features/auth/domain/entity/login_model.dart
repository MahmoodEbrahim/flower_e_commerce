import 'package:hive/hive.dart';
import 'user_model.dart';

part 'login_model.g.dart';

@HiveType(typeId: 2)
class LoginModel {
  @HiveField(0)
  final UserModel user;

  @HiveField(1)
  final String token;

  LoginModel({
    required this.user,
    required this.token,
  });
}
