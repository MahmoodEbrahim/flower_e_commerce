import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/search_products_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_product_usecase_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  late SearchProductsUseCase searchProductsUseCase;
  late MockHomeRepository mockHomeRepositoryImp;

  setUpAll(() {
    provideDummy<ApiResult<List<ProductsEntity>>>(
      ApiFailedResult<List<ProductsEntity>>("error"),
    );
    mockHomeRepositoryImp = MockHomeRepository();
    searchProductsUseCase = SearchProductsUseCase(mockHomeRepositoryImp);
  });

  group("test search usecase", () {
    test("should return ApiSuccessResult when Api called successfully", () async {
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
        mockHomeRepositoryImp.searchProducts("keyword"),
      ).thenAnswer((_) async => ApiSucessResult([fakeProductEntity]));

      final result = await searchProductsUseCase.call("keyword");

      expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
      final success = result as ApiSucessResult<List<ProductsEntity>>;
      expect(success.sucessResult, [fakeProductEntity]);
      verify(mockHomeRepositoryImp.searchProducts("keyword")).called(1);
      expect(success.sucessResult.length, 1);
      expect(success.sucessResult.first.id, "1");
    });

    test("should return ApiErrorResult ", () async {
      when(mockHomeRepositoryImp.searchProducts("keyword")).thenAnswer(
        (_) async => ApiFailedResult<List<ProductsEntity>>("Unexpected error"),
      );

      final result = await searchProductsUseCase.call("keyword");

      expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
      final failure = result as ApiFailedResult<List<ProductsEntity>>;
      expect(failure.errorMessage, isNotNull);
      expect(failure.errorMessage, contains("Unexpected error"));
    });
  });
}
