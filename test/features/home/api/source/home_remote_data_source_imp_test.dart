import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/api/models/products_by_occassion/product_by_occasion.dart';
import 'package:flower_e_commerce/features/home/api/source/home_remote_data_source_imp.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_imp_test.mocks.dart';
@GenerateMocks([HomeApiService])
void main() {
  late HomeRemoteDataSourceImp homeRemoteDataSourceImp;
late MockHomeApiService mockHomeApiService;
setUp((){
  mockHomeApiService=MockHomeApiService();
  homeRemoteDataSourceImp=HomeRemoteDataSourceImp(mockHomeApiService);
});
 group("getProductsDetialsByOccasions  test", (){
   const occasionId = '123';
   final productDetails = ProductDetailsEntity(
     id: '123',
     title: 'Rose Bouquet',
     price: 299,
     images: [
       'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png',
       'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png',
       'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png'
     ],
     imgCover: 'https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png',
     quantity: 1,
     description: 'A beautiful flower of roses',

   );
   final products=[productDetails];
   final successResponse = ProductByOccasionDto(
     message: "success",

       products: [
     Products(
       id: '123',
       title: 'Rose Bouquet',
       price: 299,
       images: [
         'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png',
         'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png',
         'https://flower.elevateegy.com/uploads/c0992ec6-d3c0-4a54-b7ec-4cf000138367-image_two.png'
       ],
       imgCover: 'https://flower.elevateegy.com/uploads/fefa790a-f0c1-42a0-8699-34e8fc065812-cover_image.png',
       quantity: 1,
       description: 'A beautiful flower of roses',
     ),
   ]);
   test("getProductsDetialsByOccasions return ApiSucceesResult when api success", ()async{
when(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>successResponse);
final result=await homeRemoteDataSourceImp.getProductsDetialsByOccasions(occasionId);
expect(result, isA<ApiSucessResult<List<ProductDetailsEntity>>>());
expect((result as ApiSucessResult).sucessResult, equals(products));
verify(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).called(1);
   });
   test("should return ApiFailedResult when products is null in response", ()async{
     final response=ProductByOccasionDto(
         message: 'success',
         products: null);
     when(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>response);
     final result=await homeRemoteDataSourceImp.getProductsDetialsByOccasions(occasionId);
     expect(result,   isA<ApiFailedResult>());
     verify(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).called(1);
   });
   test("should return ApiFailedResult when api fails on DioException", ()async{
final dioException=DioException(
    type: DioExceptionType.connectionTimeout,
    requestOptions: RequestOptions(path: ""));
when(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).thenThrow(dioException);
final result=await homeRemoteDataSourceImp.getProductsDetialsByOccasions(occasionId);
expect(result, isA<ApiFailedResult>());
expect((result as ApiFailedResult).errorMessage, ServerFailure.fromDioError(dioException).errorMessage);
verify(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).called(1);
   });
test("should return ApiFailedResult when api fails on non-DioException", ()async{
  final exception=Exception("Throw Exception");
  when(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).thenThrow(exception);
  final result=await homeRemoteDataSourceImp.getProductsDetialsByOccasions(occasionId);
  expect(result, isA<ApiFailedResult>());
  expect((result as ApiFailedResult).errorMessage, exception.toString());
  verify(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).called(1);
});
 });
   
}