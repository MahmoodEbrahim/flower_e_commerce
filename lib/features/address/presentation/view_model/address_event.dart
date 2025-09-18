import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAddAddressEvent extends AddressEvent {
  final AddAdressRequest request;
  final String token;
  GetAddAddressEvent({required this.request, required this.token});
  @override
  List<Object?> get props => [request, token];
}

class GetAllddressEvent extends AddressEvent {
  final String token;
  GetAllddressEvent({required this.token});

  @override
  List<Object?> get props => [token];
}

class DeleteAddressEvent extends AddressEvent {
  final String token;
  final String id;
  DeleteAddressEvent({required this.id, required this.token});
  @override
  List<Object?> get props => [token, id];
}

class UpdateAddressEvent extends AddressEvent {
  final String token;
  final String id;
  final AddAdressRequest request;
  UpdateAddressEvent({
    required this.id,
    required this.token,
    required this.request,
  });
  @override
  List<Object?> get props => [token, id];
}

class GetGovernorateEvent extends AddressEvent {
  @override
  List<Object?> get props => [];
}

class GetStatesEvent extends AddressEvent {
  String governateId;
  GetStatesEvent({required this.governateId});
  @override
  List<Object?> get props => [governateId];
}

class GetCountriesEvent extends AddressEvent {
  @override
  List<Object?> get props => [];
}
