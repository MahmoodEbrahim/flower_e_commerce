import 'package:flower_e_commerce/features/auth/domain/entity/user_entity.dart';

class LoginEntity {
  final UserEntity user;
  final String token;

  LoginEntity({
    required this.user,
    required this.token,
  });
}
