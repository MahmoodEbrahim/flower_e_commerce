import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable{
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;
  final String? id;
  AddressEntity({
this.street,this.id,
    this.username,
    this.phone,this.city,this.lat,this.long
});
  @override
  List<Object?> get props => [street, phone, city, lat, long, username, id];
}