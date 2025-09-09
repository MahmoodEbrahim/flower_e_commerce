import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/data/repository/home_repository_imp.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_imp_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late HomeRepositoryImp homeRepositoryImp;
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;

  setUpAll(() {
    provideDummy<ApiResult<List<ProductsEntity>>>(
      ApiFailedResult<List<ProductsEntity>>("error"),
    );
    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    homeRepositoryImp = HomeRepositoryImp(mockHomeRemoteDataSource);
  });

  group("test search", () {
    test("should return ApiSuccessResult ", () async {
      final fakeProductEntity = ProductsEntity(
        title: "Dreamy White Roses Bouquet",
        description: "Elevate any celebration with our luxury rose bouquet.",
        imgCover:
            "https://flower.elevateegy.com/uploads/2d8ddf11-935f-4a45-a100-e1e0765a39c3-cover_image.png",
        images: [
          "https://flower.elevateegy.com/uploads/8ee8e389-da6a-4371-8b13-5e35fcca16c6-image_one.png",
          "https://flower.elevateegy.com/uploads/66fc9304-3ceb-4b73-97dd-730ccf790c49-image_three.png",
          "https://flower.elevateegy.com/uploads/acf9531b-5ca9-4c45-97fc-f81df9d62091-image_two.png",
        ],
        price: 320,
        priceAfterDiscount: 199,
        id: "1",
      );

      when(
        mockHomeRemoteDataSource.searchProducts("keyword"),
      ).thenAnswer((_) async => ApiSucessResult([fakeProductEntity]));

      final result = await homeRepositoryImp.searchProducts("keyword");

      expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
      final success = result as ApiSucessResult<List<ProductsEntity>>;
      expect(success.sucessResult, [fakeProductEntity]);
      verify(mockHomeRemoteDataSource.searchProducts("keyword")).called(1);
      expect(success.sucessResult.length, 1);
      expect(success.sucessResult.first.id, "1");
    });

    test("should return ApiErrorResult ", () async {
      when(mockHomeRemoteDataSource.searchProducts("keyword")).thenAnswer(
        (_) async => ApiFailedResult<List<ProductsEntity>>("Unexpected error"),
      );

      final result = await homeRepositoryImp.searchProducts("keyword");

      expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
      final failure = result as ApiFailedResult<List<ProductsEntity>>;
      expect(failure.errorMessage, isNotNull);
      expect(failure.errorMessage, contains("Unexpected error"));
    });
  });
}
