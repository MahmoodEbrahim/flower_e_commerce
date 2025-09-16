import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/api/models/category_products_response_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/home_model.dart';
import 'package:flower_e_commerce/features/home/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/api/models/search_response_model.dart';
import 'package:flower_e_commerce/features/home/api/source/home_remote_data_source_imp.dart';
import 'package:flower_e_commerce/features/home/domain/entity/home_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_imp_test.mocks.dart';

@GenerateMocks([HomeApiService])
void main() {
  late HomeRemoteDataSourceImp homeRemoteDataSourceImp;
  late MockHomeApiService mockHomeApiService;

  // shared fake data
  late List<ProductModel> fakeProductList;
  late MetaDataDto metaData;
  late CategoryProductsResponseDto categoryProductsResponseDto;
  late SearchResponseModel searchResponseModel;
  late String catId;

  setUpAll(() {
    mockHomeApiService = MockHomeApiService();
    homeRemoteDataSourceImp = HomeRemoteDataSourceImp(mockHomeApiService);

    fakeProductList = [
      ProductModel(
        rateAvg: 5,
        rateCount: 0,
        id: "673e2e1f1159920171828153",
        title: "Dreamy White Roses Bouquet",
        slug: "dreamy-white-roses-bouquet",
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
        quantity: -1,
        category: "673c46fd1159920171827c85",
        occasion: "673b35c01159920171827aed",
        isSuperAdmin: true,
        sold: 101,
      ),
      ProductModel(
        rateAvg: 5,
        rateCount: 0,
        id: "6745096c90ab40a0685402fc",
        title: "Forever Pink | Baby Roses",
        slug: "forever-pink-or-baby-roses",
        description: "A gift of pink baby roses holds profound meaning.",
        imgCover:
        "https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png",
        images: [
          "https://flower.elevateegy.com/uploads/ef146ee3-ac7c-4bbd-a2f7-9ddae14d0656-image_four.png",
          "https://flower.elevateegy.com/uploads/6e1fa180-7b99-4dd5-95f0-032715a0f04e-image_one.png",
        ],
        price: 2049,
        priceAfterDiscount: 1899,
        quantity: 4741,
        category: "673c46fd1159920171827c85",
        occasion: "673b34c21159920171827ae0",
        isSuperAdmin: true,
        sold: 259,
      ),
    ];

    metaData = MetaDataDto(
      currentPage: 1,
      totalItems: 12,
      limit: 2,
      totalPages: 2,
    );

    categoryProductsResponseDto = CategoryProductsResponseDto(
      message: 'success',
      metadata: metaData,
      products: fakeProductList,
    );

    catId = "673c46fd1159920171827c85";

    searchResponseModel = SearchResponseModel(
      message: "success",
      metadata: metaData,
      products: fakeProductList,
    );
  });

  // ---------------- test searchProducts ----------------
  group("test searchProducts in homeRemoteDataSourceImp", () {
    test(
      'should return ApiSucessResult when API returns products that contains keyword',
          () async {
        final fakeDtoList = CategoryProductsResponseDto(products: fakeProductList);
        final fakeEntityList = fakeProductList.map((e) => e.toEntity()).toList();

        when(mockHomeApiService.searchProducts("rose"))
            .thenAnswer((_) async => fakeDtoList);

        final result = await homeRemoteDataSourceImp.searchProducts("rose");

        expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
        expect((result as ApiSucessResult).sucessResult, equals(fakeEntityList));
        verify(mockHomeApiService.searchProducts("rose")).called(1);
      },
    );

    test(
      'should return ApiSucessResult with empty list when keyword not found',
          () async {
        final emptyDtoList = CategoryProductsResponseDto(products: []);
        when(mockHomeApiService.searchProducts("NotExist"))
            .thenAnswer((_) async => emptyDtoList);

        final result = await homeRemoteDataSourceImp.searchProducts("NotExist");

        expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
        final success = result as ApiSucessResult<List<ProductsEntity>>;
        expect(success.sucessResult, isEmpty);
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
    });

    test(
      'should return ApiFailedResult when general Exception is thrown',
          () async {
        when(mockHomeApiService.searchProducts("rose"))
            .thenThrow(Exception("Unexpected error"));

        final result = await homeRemoteDataSourceImp.searchProducts("rose");

        expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
        final failure = result as ApiFailedResult<List<ProductsEntity>>;
        expect(failure.errorMessage, contains("Unexpected error"));
      },
    );
  });

  // ---------------- test getProductsByCategoryId ----------------
  group("test getProductsByCategoryId in homeRemoteDataSourceImp", () {
    test(
      "should return successApiResult",
          () async {
        when(mockHomeApiService.getProductsByCategoryId(catId))
            .thenAnswer((_) async => categoryProductsResponseDto);

        final res = await homeRemoteDataSourceImp.getProductsByCategoryId(catId);

        verify(mockHomeApiService.getProductsByCategoryId(catId)).called(1);
        expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
      },
    );

    test(
      "should return failedApiResult with dio exception",
          () async {
        final String dioMessage = "dio error";
        final DioException mockDioException = DioException(
          requestOptions: RequestOptions(path: ''),
          message: dioMessage,
        );

        when(mockHomeApiService.getProductsByCategoryId(catId))
            .thenThrow(mockDioException);

        final res = await homeRemoteDataSourceImp.getProductsByCategoryId(catId);

        expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
        final acResult = res as ApiFailedResult<List<ProductsEntity>>;
        expect(acResult.errorMessage, equals(dioMessage));
      },
    );

    test(
      "should return failedApiResult with exception",
          () async {
        final String exMessage = "exception error";
        when(mockHomeApiService.getProductsByCategoryId(catId))
            .thenThrow(Exception(exMessage));

        final res = await homeRemoteDataSourceImp.getProductsByCategoryId(catId);

        expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
      },
    );
  });

  // ---------------- test getSearchProducts ----------------
  group("test getSearchProducts in homeRemoteDataSourceImp", () {
    test(
      "should return successApiResult when category != null",
          () async {
        String filter = "price";

        when(mockHomeApiService.getSearchProducts(filter, catId))
            .thenAnswer((_) async => searchResponseModel);

        final res = await homeRemoteDataSourceImp.getSearchProducts(filter, catId);

        verify(mockHomeApiService.getSearchProducts(filter, catId)).called(1);
        expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
      },
    );

    test(
      "should return successApiResult when category == null",
          () async {
        String filter = "price";
        String? catId;

        when(mockHomeApiService.getSearchProducts(filter, catId))
            .thenAnswer((_) async => searchResponseModel);

        final res = await homeRemoteDataSourceImp.getSearchProducts(filter, catId);

        verify(mockHomeApiService.getSearchProducts(filter, catId)).called(1);
        expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
      },
    );

    test(
      "should return failedApiResult with dio exception",
          () async {
        String filter = "price";
        String? catId;
        final String dioMessage = "dio error";

        when(mockHomeApiService.getSearchProducts(filter, catId)).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: ''),
            message: dioMessage,
          ),
        );

        final res = await homeRemoteDataSourceImp.getSearchProducts(filter, catId);

        expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
      },
    );

    test(
      "should return failedApiResult with exception",
          () async {
        String filter = "price";
        String? catId;

        when(mockHomeApiService.getSearchProducts(filter, catId))
            .thenThrow(Exception("exception error"));

        final res = await homeRemoteDataSourceImp.getSearchProducts(filter, catId);

        expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
      },
    );
  });
  // ---------------- test getHomeData ----------------
  group("test getHomeData in homeRemoteDataSourceImp", () {
    test(
      "should return ApiSuccessResult when API returns HomeModel",
          () async {
        // arrange
        final homeModel = HomeModel(
          message: "success",
          products: fakeProductList,
          categories: [],
          bestSeller: [],
          occasions: [],
        );

        when(mockHomeApiService.getHomeData())
            .thenAnswer((_) async => homeModel);

        // act
        final result = await homeRemoteDataSourceImp.getHomeData();

        // assert
        verify(mockHomeApiService.getHomeData()).called(1);
        expect(result, isA<ApiSucessResult<HomeEntity>>());
        final success = result as ApiSucessResult<HomeEntity>;
        expect(success.sucessResult.products?.length, fakeProductList.length);
        expect(success.sucessResult.categories, isEmpty);
        expect(success.sucessResult.bestSeller, isEmpty);
        expect(success.sucessResult.occasions, isEmpty);
      },
    );

    test(
      "should return ApiFailedResult when DioException is thrown",
          () async {
        when(mockHomeApiService.getHomeData()).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: "/home"),
            message: "dio error",
          ),
        );

        final result = await homeRemoteDataSourceImp.getHomeData();

        expect(result, isA<ApiFailedResult<HomeEntity>>());
        final failure = result as ApiFailedResult<HomeEntity>;
        expect(failure.errorMessage, contains("dio error"));
      },
    );

    test(
      "should return ApiFailedResult when Exception is thrown",
          () async {
        when(mockHomeApiService.getHomeData())
            .thenThrow(Exception("Unexpected error"));

        final result = await homeRemoteDataSourceImp.getHomeData();

        expect(result, isA<ApiFailedResult<HomeEntity>>());
        final failure = result as ApiFailedResult<HomeEntity>;
        expect(failure.errorMessage, contains("Unexpected error"));
      },
    );
  });
}
