import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/orders/domain/entity/order_entity/orders_responce_entity.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/orders_events.dart';
import 'package:flower_e_commerce/features/orders/presentation/view_model/orders_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecase/get_orders_usecase.dart';
@injectable
class OrdersViewModel extends Bloc<OrderEvents,OrderStates>{
  final GetOrdersUseCase _getOrdersUseCase;
  @factoryMethod
  OrdersViewModel(this._getOrdersUseCase):super(OrderStates()){
    on<GetOrderEvent>(getOrders);
  }
  Future<void>getOrders(GetOrderEvent event,Emitter emit)async{
    emit(state.copyWith(isLoading: true));
    final result=await _getOrdersUseCase.GetOrders();
    print("zh2t");
    print(result.runtimeType);
    print(result);
    switch(result){
      case ApiSucessResult<OrdersResponceEntity>():
        emit(state.copyWith(isLoading: false,errorMessage: null,order: result.sucessResult));
      case ApiFailedResult<OrdersResponceEntity>():
        emit(state.copyWith(isLoading: false,errorMessage: result.errorMessage,order: state.OrdersResonse));
    }
  }
}