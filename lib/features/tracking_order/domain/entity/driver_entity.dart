import 'package:equatable/equatable.dart';

class DriverEntity extends Equatable {
  final String id;
  final String country;
  final String firstName;
  final String lastName;
  final String vehicleType;
  final String vehicleNumber;
  final String vehicleLicense;
  final String nid;
  final String nidImg;
  final String email;
  final String gender;
  final String phone;
  final String photo;
  final String role;
  final String createdAt;

  const DriverEntity({
    required this.id,
    required this.country,
    required this.firstName,
    required this.lastName,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleLicense,
    required this.nid,
    required this.nidImg,
    required this.email,
    required this.gender,
    required this.phone,
    required this.photo,
    required this.role,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    country,
    firstName,
    lastName,
    vehicleType,
    vehicleNumber,
    vehicleLicense,
    nid,
    nidImg,
    email,
    gender,
    phone,
    photo,
    role,
    createdAt,
  ];
}
