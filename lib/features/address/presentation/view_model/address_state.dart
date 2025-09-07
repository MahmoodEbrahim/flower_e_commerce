import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';

class AddressState extends Equatable{
 final RequestState addAddressRequestState;
  final String? addAddressErrorMessage;
final  AddressEntity? addressEntity;
 final RequestState getAddressRequestState;
 final String? getAddressErrorMessage;
 final  List<AddressEntity> addresses;
 AddressState({
   this.addAddressRequestState=RequestState.loading,
   this.addressEntity,
   this.addAddressErrorMessage,
   this.getAddressRequestState=RequestState.loading,
   this.getAddressErrorMessage,
   this.addresses=const []
});
 AddressState copyWith({
    RequestState? addAddressRequestState,
    String? addAddressErrorMessage,
   AddressEntity? addressEntity,
    RequestState? getAddressRequestState,
    String? getAddressErrorMessage,
     List<AddressEntity>? addresses,
}){
   return AddressState(
     addAddressRequestState: addAddressRequestState??this.addAddressRequestState,
     addAddressErrorMessage: addAddressErrorMessage??this.addAddressErrorMessage,
     addressEntity: addressEntity??this.addressEntity,
     getAddressRequestState: getAddressRequestState??this.getAddressRequestState,
     addresses: addresses??this.addresses,
     getAddressErrorMessage: getAddressErrorMessage??this.getAddressErrorMessage
   );
 }
 @override
  // TODO: implement props
  List<Object?> get props =>
     [addAddressErrorMessage,addressEntity,addAddressRequestState,
     getAddressRequestState,addresses,getAddressErrorMessage
     ];
}