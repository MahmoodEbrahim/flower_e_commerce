import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/address/data/use_case/get_add_address_use_case.dart';
import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_event.dart';
import 'package:flower_e_commerce/features/address/presentation/view_model/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class AddressBloc extends Bloc<AddressEvent,AddressState>{
GetAddAddressUseCase _addressUseCase;
AddressBloc(this._addressUseCase):super(AddressState()){
  on<GetAddAddressEvent>((event,emit)async{
    emit(state.copyWith(
      addAddressRequestState: RequestState.loading
    ));
    final result=await _addressUseCase.addAddress(event.request, event.token);
    switch(result){

      case ApiSucessResult<AddressEntity>():
      emit(state.copyWith(
        addressEntity: result.sucessResult,
        addAddressRequestState: RequestState.success
      ));
      case ApiFailedResult<AddressEntity>():
        emit(state.copyWith(
            addAddressErrorMessage: result.errorMessage,
            addAddressRequestState: RequestState.error
        ));
    }
  });
}
}