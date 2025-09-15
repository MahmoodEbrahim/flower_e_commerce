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
  late MockHomeRemoteDataSource mockHomeRemoteDataSource;
  late HomeRepositoryImp homeRepositoryImp;
  late String catId;
  late List<ProductsEntity> fakeProductsModel;
  late String filter;

  setUpAll(() {
    provideDummy<ApiResult<List<ProductsEntity>>>(
      ApiFailedResult<List<ProductsEntity>>("error"),
    );

    mockHomeRemoteDataSource = MockHomeRemoteDataSource();
    homeRepositoryImp = HomeRepositoryImp(mockHomeRemoteDataSource);

    catId = "673c46fd1159920171827c85";
    filter = "price";

    fakeProductsModel = [
      ProductsEntity(
        id: "673e2e1f1159920171828153",
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
        category: "673c46fd1159920171827c85",
        occasion: "673b35c01159920171827aed",
      ),
      ProductsEntity(
        id: "6745096c90ab40a0685402fc",
        title: "Forever Pink | Baby Roses",
        description: "A gift of pink baby roses holds profound meaning.",
        imgCover:
        "https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png",
        images: [
          "https://flower.elevateegy.com/uploads/ef146ee3-ac7c-4bbd-a2f7-9ddae14d0656-image_four.png",
          "https://flower.elevateegy.com/uploads/6e1fa180-7b99-4dd5-95f0-032715a0f04e-image_one.png",
        ],
        price: 2049,
        priceAfterDiscount: 1899,
        category: "673c46fd1159920171827c85",
        occasion: "673b34c21159920171827ae0",
      ),
    ];
  });

  // -------- test getProductsByCategoryId ----------
  group("test getProductsByCategoryId in HomeRepositoryImp", () {
    test(
      "should return ApiSuccessResult",
          () async {
        final mockResult = ApiSucessResult<List<ProductsEntity>>(fakeProductsModel);
        provideDummy<ApiResult<List<ProductsEntity>>>(mockResult);

        when(mockHomeRemoteDataSource.getProductsByCategoryId(catId))
            .thenAnswer((_) async => mockResult);

        final res = await homeRepositoryImp.getProductsByCategoryId(catId);

        expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
        final acResult = res as ApiSucessResult<List<ProductsEntity>>;
        expect(acResult.sucessResult[0].id, equals(fakeProductsModel[0].id));
        verify(mockHomeRemoteDataSource.getProductsByCategoryId(catId)).called(1);
      },
    );

    test(
      "should return ApiFailedResult",
          () async {
        final mockError = ApiFailedResult<List<ProductsEntity>>("Network error");
        provideDummy<ApiResult<List<ProductsEntity>>>(mockError);

        when(mockHomeRemoteDataSource.getProductsByCategoryId(catId))
            .thenAnswer((_) async => mockError);

        final res = await homeRepositoryImp.getProductsByCategoryId(catId);

        expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
        final failResult = res as ApiFailedResult<List<ProductsEntity>>;
        expect(failResult.errorMessage, equals("Network error"));
      },
    );
  });

  // -------- test getSearchProducts ----------
  group("test getSearchProducts in HomeRepositoryImp", () {
    test(
      "should return ApiSuccessResult when category != null",
          () async {
        final mockResult = ApiSucessResult<List<ProductsEntity>>(fakeProductsModel);
        provideDummy<ApiResult<List<ProductsEntity>>>(mockResult);

        when(mockHomeRemoteDataSource.getSearchProducts(filter, catId))
            .thenAnswer((_) async => mockResult);

        final res = await homeRepositoryImp.getSearchProducts(filter, catId);

        expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
        final acResult = res as ApiSucessResult<List<ProductsEntity>>;
        expect(acResult.sucessResult.first.id, equals(fakeProductsModel[0].id));
      },
    );

    test(
      "should return ApiSuccessResult when category == null",
          () async {
        String? catId;
        final mockResult = ApiSucessResult<List<ProductsEntity>>(fakeProductsModel);
        provideDummy<ApiResult<List<ProductsEntity>>>(mockResult);

        when(mockHomeRemoteDataSource.getSearchProducts(filter, catId))
            .thenAnswer((_) async => mockResult);

        final res = await homeRepositoryImp.getSearchProducts(filter, catId);

        expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
      },
    );

    test(
      "should return ApiFailedResult",
          () async {
        final mockError = ApiFailedResult<List<ProductsEntity>>("Network error");
        provideDummy<ApiResult<List<ProductsEntity>>>(mockError);

        when(mockHomeRemoteDataSource.getSearchProducts(filter, catId))
            .thenAnswer((_) async => mockError);

        final res = await homeRepositoryImp.getSearchProducts(filter, catId);

        expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
        final failResult = res as ApiFailedResult<List<ProductsEntity>>;
        expect(failResult.errorMessage, equals("Network error"));
      },
    );
  });

  // -------- test searchProducts ----------
  group("test searchProducts in HomeRepositoryImp", () {
    test("should return ApiSuccessResult", () async {
      final fakeProductEntity = ProductsEntity(
        id: "1",
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
      );

      when(mockHomeRemoteDataSource.searchProducts("keyword"))
          .thenAnswer((_) async => ApiSucessResult([fakeProductEntity]));

      final result = await homeRepositoryImp.searchProducts("keyword");

      expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
      final success = result as ApiSucessResult<List<ProductsEntity>>;
      expect(success.sucessResult, [fakeProductEntity]);
      verify(mockHomeRemoteDataSource.searchProducts("keyword")).called(1);
    });

    test("should return ApiFailedResult", () async {
      when(mockHomeRemoteDataSource.searchProducts("keyword")).thenAnswer(
            (_) async => ApiFailedResult<List<ProductsEntity>>("Unexpected error"),
      );

      final result = await homeRepositoryImp.searchProducts("keyword");

      expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
      final failure = result as ApiFailedResult<List<ProductsEntity>>;
      expect(failure.errorMessage, contains("Unexpected error"));
    });
  });
}
