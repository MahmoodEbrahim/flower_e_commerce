import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/models/products_by_occassion/product_by_occasion.dart';
import 'package:flower_e_commerce/features/home/data/repository/home_repository_imp.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_imp_test.mocks.dart';
@GenerateMocks([HomeRemoteDataSource])
void main() {
 late HomeRepositoryImp homeRepositoryImp;
 late MockHomeRemoteDataSource mockHomeRemoteDataSource;
 setUp(() {
  mockHomeRemoteDataSource = MockHomeRemoteDataSource();
  homeRepositoryImp = HomeRepositoryImp(mockHomeRemoteDataSource);
  provideDummy<ApiResult<List<ProductDetailsEntity>>>(
   ApiFailedResult<List<ProductDetailsEntity>>('Dummy error'),
  );
 });
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
 final products = [productDetails];
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
 test('should return ApiSuccessResult with products when data source returns success', () async{
  when(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>ApiSucessResult<List<ProductDetailsEntity>>(products));
  final result=await homeRepositoryImp.getProductsDetialsByOccasions(occasionId);
  expect(result, isA<ApiSucessResult<List<ProductDetailsEntity>>>());
  expect((result as ApiSucessResult).sucessResult, equals(products));
  verify(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).called(1);
 });
 test('should return ApiFailedResult with null products when data source returns success', () async{
  when(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>
      ApiFailedResult<List<ProductDetailsEntity>>("Products is null"));
  final result=await homeRepositoryImp.getProductsDetialsByOccasions(occasionId);
  expect(result, isA<ApiFailedResult<List<ProductDetailsEntity>>>());
  expect((result as ApiFailedResult).errorMessage, equals("Products is null"));
  verify(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).called(1);
 });
test("should return ApiFailedResult when remote data source fails", ()async{
 when(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId))
     .thenAnswer((_) async => ApiFailedResult<List<ProductDetailsEntity>>('Server error'));
 final result = await homeRepositoryImp.getProductsDetialsByOccasions(occasionId);
 expect(result, isA<ApiFailedResult<List<ProductDetailsEntity>>>());
 expect((result as ApiFailedResult).errorMessage, equals('Server error'));
 verify(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).called(1);

});


}
