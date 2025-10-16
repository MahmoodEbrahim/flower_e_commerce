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
    required  this.token,
  });
  // UserModel toEntity(){
  //   return UserModel(
  //     firstName: user.firstName,
  //     lastName: user.lastName,
  //     phone: user.phone,
  //     photo: user.photo,
  //     email: user.email,
  //     Id: user.Id,
  //     gender: user.gender,
  //     role: user.role,
  //     addresses: user.addresses,
  //     wishlist: user.wishlist
  //   );
  // }
}
