import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
@immutable
abstract class ProductsDetialsOccasionEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class GetProductsDetialsByOccasionEvent extends ProductsDetialsOccasionEvent{
  final String occassionId;
  GetProductsDetialsByOccasionEvent({required this.occassionId});
@override
  // TODO: implement props
  List<Object> get props => [occassionId];
}