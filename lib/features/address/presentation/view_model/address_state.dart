import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';

class AddressState extends Equatable{
 final RequestState addAddressRequestState;
  final String? addAddressErrorMessage;
final  AddressEntity? addressEntity;
 AddressState({
   this.addAddressRequestState=RequestState.loading,
   this.addressEntity,
   this.addAddressErrorMessage
});
 AddressState copyWith({
    RequestState? addAddressRequestState,
    String? addAddressErrorMessage,
   AddressEntity? addressEntity
}){
   return AddressState(
     addAddressRequestState: addAddressRequestState??this.addAddressRequestState,
     addAddressErrorMessage: addAddressErrorMessage??this.addAddressErrorMessage,
     addressEntity: addressEntity??this.addressEntity
   );
 }
 @override
  // TODO: implement props
  List<Object?> get props =>
     [addAddressErrorMessage,addressEntity,addAddressRequestState];
}