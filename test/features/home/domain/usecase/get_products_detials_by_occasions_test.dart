import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_detals_entity.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_products_detials_by_occasions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';

import 'get_products_detials_by_occasions_test.mocks.dart';
@GenerateMocks([HomeRepository])
void main() {
late GetProductDetialsByOccasionUseCase productDetialsByOccasionUseCase;
late MockHomeRepository mockHomeRepository;
setUp((){
  mockHomeRepository=MockHomeRepository();
  productDetialsByOccasionUseCase=GetProductDetialsByOccasionUseCase(mockHomeRepository);
  provideDummy<ApiResult<List<ProductDetailsEntity>>>(
    ApiFailedResult<List<ProductDetailsEntity>>('Dummy error'),
  );
});
  group("GetProductDetialsByOccasionUseCase test", (){
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
    test("should return ApiSuccessResult when Repositry Success", ()async{
when(mockHomeRepository.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>ApiSucessResult(products));
final result=await productDetialsByOccasionUseCase.getProductsDetialsByOccasions(occasionId);
expect(result, isA<ApiSucessResult<List<ProductDetailsEntity>>>());
expect((result as ApiSucessResult).sucessResult, equals(products));
verify(mockHomeRepository.getProductsDetialsByOccasions(occasionId));
    });
    test("should return ApiFailedResult when null products", ()async{
      when(mockHomeRepository.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>
          ApiFailedResult<List<ProductDetailsEntity>>("products is null"));
      final result=await productDetialsByOccasionUseCase.getProductsDetialsByOccasions(occasionId);
      expect(result, isA<ApiFailedResult<List<ProductDetailsEntity>>>());
      expect((result as ApiFailedResult).errorMessage, equals("products is null"));
      verify(mockHomeRepository.getProductsDetialsByOccasions(occasionId)).called(1);
    });
    test("should return ApiFailedResult when Repositry Failed", ()async{
      when(mockHomeRepository.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>
          ApiFailedResult<List<ProductDetailsEntity>>("error with server"));
      final result=await productDetialsByOccasionUseCase.getProductsDetialsByOccasions(occasionId);
      expect(result, isA<ApiFailedResult<List<ProductDetailsEntity>>>());
      expect((result as ApiFailedResult).errorMessage, equals("error with server"));
      verify(mockHomeRepository.getProductsDetialsByOccasions(occasionId)).called(1);
    });

  });
}