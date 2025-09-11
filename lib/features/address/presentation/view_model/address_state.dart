import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';

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
 final RequestState governorateRequestState;
 final  List<GovernorateEntity> governorates;
 final RequestState stateRequestState;
 final  List<StateEntity> states;
 final RequestState countryRequestState;
 final String? countryErrorMessage;
 final  List<CountryEntity> countries;
 final RequestState updateState;
 final  List<AddressEntity> updateAddresses;
 final String? UpdateAddressErrorMessage;

 AddressState({
   this.addAddressRequestState=RequestState.loading,
   this.addressEntity,
   this.addAddressErrorMessage,
   this.getAddressRequestState=RequestState.loading,
   this.getAddressErrorMessage,
   this.addresses=const [],
   this.deleteAddressRequestState=RequestState.loading,
   this.removeAddressDto,
   this.deleteAddressErrorMessage,
   this.governorateRequestState=RequestState.loading,

   this.governorates=const [],
   this.stateRequestState=RequestState.loading,

   this.states=const [],
this.countryRequestState=RequestState.loading,
   this.countryErrorMessage,
   this.countries=const [],
   this.updateState=RequestState.loading,
   this.updateAddresses=const [],
   this.UpdateAddressErrorMessage
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
    RequestState? governorateRequestState,
    String? governateErrorMessage,
     List<GovernorateEntity>? governorates,
    RequestState? stateRequestState,
    String? stateErrorMessage,
     List<StateEntity>? states,
    RequestState? countryRequestState,
    String? countryErrorMessage,
     List<CountryEntity>? countries,
    RequestState? updateState,
     List<AddressEntity>? updateAddresses,
    String? UpdateAddressErrorMessage

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
     deleteAddressRequestState: deleteAddressRequestState??this.deleteAddressRequestState,
     governorateRequestState: governorateRequestState??this.governorateRequestState,
     governorates: governorates??this.governorates,
     stateRequestState: stateRequestState??this.stateRequestState,
     states: states??this.states,
     countryRequestState: countryRequestState??this.countryRequestState,
     countries: countries??this.countries,
     countryErrorMessage: countryErrorMessage??this.countryErrorMessage,
     updateState: updateState??this.updateState,
     updateAddresses: updateAddresses??this.updateAddresses,
       UpdateAddressErrorMessage: UpdateAddressErrorMessage??this.UpdateAddressErrorMessage
   );
 }
 @override
  List<Object?> get props =>
     [addAddressErrorMessage,addressEntity,addAddressRequestState,
     getAddressRequestState,addresses,getAddressErrorMessage,
       deleteAddressErrorMessage,deleteAddressRequestState,removeAddressDto,
       governorates,governorateRequestState,stateRequestState,states,
       countryErrorMessage,countryErrorMessage,countryRequestState,
       updateAddresses,updateState,UpdateAddressErrorMessage
     ];
}