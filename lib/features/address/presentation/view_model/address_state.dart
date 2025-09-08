import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';

class AddressState extends Equatable{
 final RequestState addAddressRequestState;
  final String? addAddressErrorMessage;
final   List<AddressEntity>? addressEntity;
 final RequestState getAddressRequestState;
 final String? getAddressErrorMessage;
 final  List<AddressEntity> addresses;
 final RequestState deleteAddressRequestState;
 final String? deleteAddressErrorMessage;
 final  RemoveAddressDto? removeAddressDto;
 AddressState({
   this.addAddressRequestState=RequestState.loading,
   this.addressEntity,
   this.addAddressErrorMessage,
   this.getAddressRequestState=RequestState.loading,
   this.getAddressErrorMessage,
   this.addresses=const [],
   this.deleteAddressRequestState=RequestState.loading,
   this.removeAddressDto,
   this.deleteAddressErrorMessage
});
 AddressState copyWith({
    RequestState? addAddressRequestState,
    String? addAddressErrorMessage,
   List<AddressEntity>? addressEntity,
    RequestState? getAddressRequestState,
    String? getAddressErrorMessage,
     List<AddressEntity>? addresses,
    RequestState? deleteAddressRequestState,
    String? deleteAddressErrorMessage,
     RemoveAddressDto? removeAddressDto,
}){
   return AddressState(
     addAddressRequestState: addAddressRequestState??this.addAddressRequestState,
     addAddressErrorMessage: addAddressErrorMessage??this.addAddressErrorMessage,
     addressEntity: addressEntity??this.addressEntity,
     getAddressRequestState: getAddressRequestState??this.getAddressRequestState,
     addresses: addresses??this.addresses,
     getAddressErrorMessage: getAddressErrorMessage??this.getAddressErrorMessage,
     deleteAddressErrorMessage: deleteAddressErrorMessage??this.deleteAddressErrorMessage,
     removeAddressDto: removeAddressDto??this.removeAddressDto,
     deleteAddressRequestState: deleteAddressRequestState??this.deleteAddressRequestState
   );
 }
 @override
  List<Object?> get props =>
     [addAddressErrorMessage,addressEntity,addAddressRequestState,
     getAddressRequestState,addresses,getAddressErrorMessage,
       deleteAddressErrorMessage,deleteAddressRequestState,removeAddressDto
     ];
}