import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'adress_entity.g.dart';
@HiveType(typeId: 3)
class AddressEntity extends Equatable{
  @HiveField(0)
  final String? street;
  @HiveField(1)
  final String? phone;
  @HiveField(2)
  final String? city;
  @HiveField(3)
  final String? lat;
  @HiveField(4)
  final String? long;
  @HiveField(5)
  final String? username;
  @HiveField(7)
  final String? id;
  AddressEntity({
this.street,this.id,
    this.username,
    this.phone,this.city,this.lat,this.long
});
  @override
  List<Object?> get props => [street,
    phone, city, lat, long, username, id];
}