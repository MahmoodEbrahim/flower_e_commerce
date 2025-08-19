import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 1)
class UserEntity {
  @HiveField(0)
  final String? Id;

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

  @HiveField(10)
  final String? createdAt;

  UserEntity({
    this.Id,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
    this.role,
    this.wishlist,
    this.addresses,
    this.createdAt,
  });
}
