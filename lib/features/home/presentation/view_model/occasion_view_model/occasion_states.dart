import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter/material.dart';
@immutable
class OccasionStates extends Equatable{
 final RequestState requestState;
 final List<ProductsEntity>productsDetials;
 final String? errorMessage;
 OccasionStates({
   this.productsDetials=const [],
   this.requestState=RequestState.loading,
   this.errorMessage
});
 OccasionStates copyWith({
    RequestState? requestState,
    List< ProductsEntity>?productsDetials,
    String? errorMessage
}){
   return OccasionStates(
     requestState: requestState??this.requestState,
     errorMessage: errorMessage??this.errorMessage,
     productsDetials: productsDetials??this.productsDetials
   );
 }
  @override
  // TODO: implement props
  List<Object?> get props => [
    requestState,errorMessage,productsDetials
  ];
}
