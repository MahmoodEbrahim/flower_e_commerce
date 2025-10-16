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
  UserModel copyWith({
    String? iid,
    String? firstName,
    String? lastName,
    String? email,
    String? gender,
    String? phone,
    String? photo,
    String? role,
    List<dynamic>? wishlist,
    List<dynamic>? addresses,
  }) {
    return UserModel(
      iid: iid ?? this.iid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      role: role ?? this.role,
      wishlist: wishlist ?? this.wishlist,
      addresses: addresses ?? this.addresses,
    );
  }
}
