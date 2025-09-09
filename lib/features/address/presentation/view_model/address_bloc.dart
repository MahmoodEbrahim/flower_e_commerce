import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/api/models/response/remove_address_dto.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/city_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/country_entity.dart';
import 'package:flower_e_commerce/features/address/domain/entity/governate_entity.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_address_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_cities_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_countries_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_all_governorate_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/use_case/get_delete_address_use_case.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/get_add_address_use_case.dart';
@injectable
class AddressBloc extends Bloc<AddressEvent,AddressState>{
GetAddAddressUseCase _addressUseCase;
GetAllAddressesUseCase _getAllAddressesUseCase;
GetDeleteAddressUseCase _deleteAddressUseCase;
GetAllGovernorateUseCase _getAllGovernorateUseCase;
GetAllStatesUseCase _allStatesUseCase;
GetAllCountriesUseCase _getAllCountriesUseCase;
AddressBloc(this._addressUseCase,this._getAllAddressesUseCase,this._deleteAddressUseCase,
    this._getAllGovernorateUseCase,this._allStatesUseCase,this._getAllCountriesUseCase):super(AddressState()){
  on<GetAddAddressEvent>((event,emit)async{
    emit(state.copyWith(
      addAddressRequestState: RequestState.loading
    ));
    final result=await _addressUseCase.addAddress(event.request, event.token);
    switch(result){

      case ApiSucessResult<List<AddressEntity>>():
      emit(state.copyWith(
        addressEntity: result.sucessResult,
        addAddressRequestState: RequestState.success
      ));
      case ApiFailedResult<List<AddressEntity>>():
        emit(state.copyWith(
            addAddressErrorMessage: result.errorMessage,
            addAddressRequestState: RequestState.error
        ));
    }
  });
  on<GetAllddressEvent>((event,emit)async{
    emit(state.copyWith(
      getAddressRequestState: RequestState.loading
    ));
    final result=await _getAllAddressesUseCase.getAllAddress(event.token);
    switch(result){

      case ApiSucessResult<List<AddressEntity>>():
      emit(state.copyWith(
        addresses: result.sucessResult,
        getAddressRequestState: RequestState.success
      ));
      case ApiFailedResult<List<AddressEntity>>():
        emit(state.copyWith(
            getAddressErrorMessage: result.errorMessage,
            getAddressRequestState: RequestState.error
        ));
    }

  });
  on<DeleteAddressEvent>((event,emit)async{
    emit(state.copyWith(
      deleteAddressRequestState: RequestState.loading
    ));
    final result=await _deleteAddressUseCase.removeAddress(event.token, event.id!);
    switch(result){

      case ApiSucessResult<RemoveAddressDto>():
       emit(state.copyWith(
         deleteAddressRequestState: RequestState.success,
         removeAddressDto: result.sucessResult
       ));
      case ApiFailedResult<RemoveAddressDto>():
        emit(state.copyWith(
            deleteAddressRequestState: RequestState.error,
          deleteAddressErrorMessage: result.errorMessage
        ));
    }
  });
  on<GetGovernorateEvent>((event,emit)async{
    emit(state.copyWith(
      governorateRequestState: RequestState.loading
    ));
    final result=await _getAllGovernorateUseCase.getGovernorates();
    switch(result){
      case ApiSucessResult<List<GovernorateEntity>>():
    emit(state.copyWith(
      governorateRequestState: RequestState.success,
      governorates: result.sucessResult
    ));
      case ApiFailedResult<List<GovernorateEntity>>():
        emit(state.copyWith(
            governorateRequestState: RequestState.error,
            governateErrorMessage: result.errorMessage
        ));
    }
  });
  on<GetStatesEvent>((event,emit)async{
    emit(state.copyWith(
      stateRequestState: RequestState.loading
    ));
    final result=await _allStatesUseCase.getStates(event.governateId);
    switch(result){
      case ApiSucessResult<List<StateEntity>>():

      emit(state.copyWith(
        stateRequestState: RequestState.success,
        states: result.sucessResult
      ));
      case ApiFailedResult<List<StateEntity>>():
emit(state.copyWith(
  stateRequestState: RequestState.error,
  stateErrorMessage: result.errorMessage
));
    }
  });
  on<GetCountriesEvent>((event,emit)async{
    emit(state.copyWith(
      countryRequestState: RequestState.loading
    ));
    final result=await _getAllCountriesUseCase.getCountries();
    switch(result){
      case ApiSucessResult<List<CountryEntity>>():
   emit(state.copyWith(
     countryRequestState: RequestState.success,
     countries: result.sucessResult
   ));
      case ApiFailedResult<List<CountryEntity>>():
        emit(state.copyWith(
            countryRequestState: RequestState.error,
            countryErrorMessage: result.errorMessage
        ));
    }
  });
}
}