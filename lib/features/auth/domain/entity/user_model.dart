import 'package:flower_e_commerce/features/auth/domain/entity/login_model.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String? iid;

  @HiveField(1)
  final String? firstName;

  @HiveField(2)
  final String? lastName;

  @HiveField(3)
  final String? email;

  @HiveField(4)
  final String? gender;

  @HiveField(5)
  final String? phone;

  @HiveField(6)
  final String? photo;

  @HiveField(7)
  final String? role;

  @HiveField(8)
  final List<dynamic>? wishlist;

  @HiveField(9)
  final List<dynamic>? addresses;


  UserModel({
    this.iid,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
  });
//   LoginModel toEntity(){
//     return LoginModel(
//
// user: UserModel(
//   lastName: lastName,
//   firstName: firstName,
//   email: email,
//   gender: gender,
//   phone: phone,
//   photo: photo,
//   role: role,
//   addresses: addresses,
//   wishlist: wishlist,
//   Id: Id
// ),token: ""
//     );
//   }
}
