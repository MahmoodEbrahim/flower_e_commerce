import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_products_detials_by_occasions.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_events.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/occasion_view_model/occasion_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class ProductsDetialsOccasionBloc extends
Bloc<ProductsDetialsOccasionEvent,OccasionStates>{
  GetProductDetialsByOccasionUseCase _byOccasionUseCase;
  ProductsDetialsOccasionBloc(this._byOccasionUseCase):super(OccasionStates()){
    on<GetProductsDetialsByOccasionEvent>((event, emit) async {
    emit(state.copyWith(requestState: RequestState.init));

final result =
      await _byOccasionUseCase.getProductsDetialsByOccasions(event.occassionId);
    switch(result){

      case ApiSucessResult<List<ProductDetailsEntity>>():
        emit(state.copyWith(requestState: RequestState.success,
        productsDetials: result.sucessResult
        ));
      case ApiFailedResult<List<ProductDetailsEntity>>():
        emit(state.copyWith(requestState: RequestState.error,
           errorMessage: result.errorMessage
        ));
    }
    });

  }



}