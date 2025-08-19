import 'package:hive/hive.dart';
import 'user_entity.dart';

part 'login_entity.g.dart';

@HiveType(typeId: 2)
class LoginEntity {
  @HiveField(0)
  final UserEntity user;

  @HiveField(1)
  final String token;

  LoginEntity({
    required this.user,
    required this.token,
  });
}
