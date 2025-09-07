import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/address/api/models/request/add_adress_request.dart';

abstract class AddressEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetAddAddressEvent extends AddressEvent{
  final AddAdressRequest request;
  final String token;
  GetAddAddressEvent({
    required this.request,
    required this.token
});
@override
  // TODO: implement props
  List<Object?> get props => [request,token];
}
class GetAllddressEvent extends AddressEvent{
  final String token;
  GetAllddressEvent({

    required this.token
  });
  @override
  // TODO: implement props
  List<Object?> get props => [token];
}