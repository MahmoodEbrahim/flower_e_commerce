import 'package:dio/dio.dart';
import 'package:flower_e_commerce/core/api_error/api_error.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/client/home_api_service.dart';
import 'package:flower_e_commerce/features/home/api/models/category_products_response_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce/features/home/api/models/product_model.dart';
import 'package:flower_e_commerce/features/home/api/models/products_by_occassion/product_by_occasion.dart';
import 'package:flower_e_commerce/features/home/api/source/home_remote_data_source_imp.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
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
   final productDetails = ProductsEntity(
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
   final occasionProducts=[productDetails];
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
when(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).thenAnswer
  ((_)async=>successResponse);
final result=await homeRemoteDataSourceImp.
getProductsDetialsByOccasions(occasionId);
expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
expect((result as ApiSucessResult).sucessResult,equals(occasionProducts));
verify(mockHomeApiService.getProductsDetialsByOccasions(occasionId)).called(1);
   });
   test("should return ApiFailedResult when products is null in response",
           ()async{
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



  late MetaDataDto metaData;
  late CategoryProductsResponseDto categoryProductsResponseDto;
  late String catId;
   List<ProductModel> fakeProductList;
  fakeProductList = [
    ProductModel(
      rateAvg: 5,
      rateCount: 0,
      id: "673e2e1f1159920171828153",
      title: "Dreamy White Roses Bouquet",
      slug: "dreamy-white-roses-bouquet",
      description:
      "Elevate any celebration with our luxury rose bouquet. This exquisite arrangement features pristine white roses wrapped in a sophisticated dark teal wrap, creating a stunning visual contrast. Perfect for celebrations, anniversaries, or as a heartfelt gift, this bouquet combines timeless elegance with modern style. Make a memorable impression with this luxurious floral arrangement. Buy now to delight your loved ones with the beauty and grace of these premium roses.",
      imgCover:
      "https://flower.elevateegy.com/uploads/2d8ddf11-935f-4a45-a100-e1e0765a39c3-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/8ee8e389-da6a-4371-8b13-5e35fcca16c6-image_one.png",
        "https://flower.elevateegy.com/uploads/66fc9304-3ceb-4b73-97dd-730ccf790c49-image_three.png",
        "https://flower.elevateegy.com/uploads/acf9531b-5ca9-4c45-97fc-f81df9d62091-image_two.png"
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
      description:
      "A gift of pink baby roses holds profound meaning. It symbolizes love, gratitude, and appreciation, making it a perfect choice for any occasion. The soft, feminine hue of pink baby roses embodies notions of nurturing and emotional love. They are also a gentle way to express sympathy or convey a message filled with kindness. These pink baby roses represent a significant gesture of love or a heartfelt wish for good luck and happiness. Embrace the power of pink roses to convey your emotions and leave a lasting impression.",
      imgCover:
      "https://flower.elevateegy.com/uploads/336d4a68-109d-4f29-a35c-d5ca2215b4ff-cover_image.png",
      images: [
        "https://flower.elevateegy.com/uploads/ef146ee3-ac7c-4bbd-a2f7-9ddae14d0656-image_four.png",
        "https://flower.elevateegy.com/uploads/6e1fa180-7b99-4dd5-95f0-032715a0f04e-image_one.png",
        "https://flower.elevateegy.com/uploads/3594e620-5411-4c6f-bf4f-188e312ee391-image_three.png",
        "https://flower.elevateegy.com/uploads/8cfb2f72-c8e8-47f6-bf10-70f43b3e0fed-image_two.png"
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
  metaData =
      MetaDataDto(currentPage: 1, totalItems: 12, limit: 2, totalPages: 2);
  categoryProductsResponseDto = CategoryProductsResponseDto(
      message: 'success', metadata: metaData, products:fakeProductList);

  catId = "673c46fd1159920171827c85";


  group("test getProductsByCategoryId in homeRemoteDataSourceImp", () {

    test(
        "when call getProductsByCategoryId with catedgory id as a parameter it should return successApiResult ",
        () async {
      // arrange

      when(mockHomeApiService.getProductsByCategoryId(catId))
          .thenAnswer((_) async => categoryProductsResponseDto);

      //act
      final res = await homeRemoteDataSourceImp.getProductsByCategoryId(catId);

      //assert
      verify(mockHomeApiService.getProductsByCategoryId(catId)).called(1);
      expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
      final acResult = res as ApiSucessResult<List<ProductsEntity>>;
      expect(acResult.sucessResult[0].id,
          categoryProductsResponseDto.products![0].Id);
    });

    test(
        "when call getProductsByCategoryId with catedgory id as a parameter it should return failedApiResult with dio exception ",
        () async {
      // arrange

      final String dioExceptionMessage = "dio error";
      final DioException mockDioException = DioException(
          requestOptions: RequestOptions(
            path: '',
          ),
          message: dioExceptionMessage);

      when(mockHomeApiService.getProductsByCategoryId(catId))
          .thenThrow(mockDioException);

      // act
      final res = await homeRemoteDataSourceImp.getProductsByCategoryId(catId);

      //assert

      verify(mockHomeApiService.getProductsByCategoryId(catId)).called(1);
      expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
      final acResult = res as ApiFailedResult<List<ProductsEntity>>;
      expect(acResult.errorMessage, equals(dioExceptionMessage));
    });
  });

  test(
      "when call getProductsByCategoryId with catedgory id as a parameter it should return failedApiResult with exception ",
      () async {
    //arrange
    final String exceptionMessage = "exception error";
    final Exception mockException = Exception(exceptionMessage);
    when(mockHomeApiService.getProductsByCategoryId(catId))
        .thenThrow(mockException);

    //act
    final res = await homeRemoteDataSourceImp.getProductsByCategoryId(catId);

    //assert

    verify(mockHomeApiService.getProductsByCategoryId(catId)).called(1);
    expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
    final acResult = res as ApiFailedResult<List<ProductsEntity>>;
    expect(acResult.errorMessage, equals(mockException.toString()));
  });
}