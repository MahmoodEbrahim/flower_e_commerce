import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/api/models/category_products_response_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/api/source/home_remote_data_source_imp.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_dara_source_impl_test.mocks.dart';

@GenerateMocks([HomeApiService])
void main() {
  late HomeRemoteDataSourceImp homeRemoteDataSourceImp;
  late MockHomeApiService mockHomeApiService;

  setUpAll(() {
    mockHomeApiService = MockHomeApiService();
    homeRemoteDataSourceImp = HomeRemoteDataSourceImp(mockHomeApiService);
  });

  group("test search", () {
    test(
      'should return ApiSucessResult when API returns products that contains keyword',
      () async {
        final fakeListProductDto = [
          ProductModel(
            title: "Dreamy White Roses Bouquet",
            slug: "dreamy-white-roses-bouquet",
            description:
                "Elevate any celebration with our luxury rose bouquet.",
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
          ),
          ProductModel(
            title: "Moko's Assorted Chocolate Box | Bright Roses",
            slug: "moko's-assorted-chocolate-box-or-bright-roses",
            description:
                "Presenting the Moko Chocolate Box, a luxurious indulgence crafted to delight the senses. This exquisite box contains 25 pieces of mixed-flavor chocolates, each a masterpiece of taste and texture. From rich dark chocolate to creamy milk chocolate, every piece is a celebration of fine craftsmanship and gourmet delight. Accompanied by delicate white baby roses and cheerful yellow gerbera daisies, this gift embodies elegance and warmth. Whether you're celebrating a special occasion or simply expressing appreciation, the Moko Chocolate Box promises a tasteful and heartfelt gesture that will leave a lasting impression.",
            imgCover:
                "https://flower.elevateegy.com/uploads/772fba4d-4c99-480f-bc67-f3d28483648e-cover_image.png",
            images: [
              "https://flower.elevateegy.com/uploads/05b528fc-7551-4a3d-8841-da0e8b97e049-image_four.png",
              "https://flower.elevateegy.com/uploads/a3d326bf-c883-4a19-8445-cf15e44c0cd0-image_one.png",
            ],
            price: 1200,
            priceAfterDiscount: 999,
            quantity: 376,

            isSuperAdmin: true,
            sold: 24,
            id: "2",
          ),
        ];

        final fakeProductDtoList = CategoryProductsResponseDto(
          products: fakeListProductDto,
        );
        final fakeProductEntityList = fakeListProductDto
            .map((e) => e.toEntity())
            .toList();

        when(
          mockHomeApiService.searchProducts("rose"),
        ).thenAnswer((_) async => fakeProductDtoList);

        //act
        final result = await homeRemoteDataSourceImp.searchProducts("rose");

        //assert
        expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
        expect(
          (result as ApiSucessResult).sucessResult,
          equals(fakeProductEntityList),
        );
        verify(mockHomeApiService.searchProducts("rose")).called(1);

        final success = result as ApiSucessResult<List<ProductsEntity>>;
        expect(success.sucessResult.length, equals(2));

        final first = success.sucessResult.first;
        expect(first.title, equals("Dreamy White Roses Bouquet"));
        expect(first.price, equals(320));
        expect(first.priceAfterDiscount, equals(199));

        final second = success.sucessResult[1];
        expect(
          second.title,
          equals("Moko's Assorted Chocolate Box | Bright Roses"),
        );
        expect(second.price, equals(1200));
        expect(second.priceAfterDiscount, equals(999));
      },
    );

    test(
      'should return ApiSucessResult with empty list when keyword not found',
      () async {
        // arrange
        final emptyProductDtoList = CategoryProductsResponseDto(products: []);
        when(
          mockHomeApiService.searchProducts("NotExist"),
        ).thenAnswer((_) async => emptyProductDtoList);

        // act
        final result = await homeRemoteDataSourceImp.searchProducts("NotExist");

        // assert
        expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
        final success = result as ApiSucessResult<List<ProductsEntity>>;
        expect(success.sucessResult, isEmpty);
        verify(mockHomeApiService.searchProducts("NotExist")).called(1);
      },
    );

    test('should return ApiFailedResult when DioException is thrown', () async {
      when(mockHomeApiService.searchProducts("rose")).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: "/search"),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      final result = await homeRemoteDataSourceImp.searchProducts("rose");

      expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
      final failed = result as ApiFailedResult;
      expect(failed.errorMessage, isNotNull);
      verify(mockHomeApiService.searchProducts("rose")).called(1);
    });

    test(
      'should return ApiFailedResult when general Exception is thrown',
      () async {
        // arrange
        when(
          mockHomeApiService.searchProducts("rose"),
        ).thenThrow(Exception("Unexpected error"));

        // act
        final result = await homeRemoteDataSourceImp.searchProducts("rose");

        // assert
        expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
        final failure = result as ApiFailedResult<List<ProductsEntity>>;
        expect(failure.errorMessage, contains("Unexpected error"));
        verify(mockHomeApiService.searchProducts("rose")).called(1);
      },
    );
  });
}
