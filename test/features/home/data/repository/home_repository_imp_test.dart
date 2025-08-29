import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/api/models/products_by_occassion/product_by_occasion.dart';
import 'package:flower_e_commerce/features/home/data/repository/home_repository_imp.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_details_entity.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_imp_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
 late HomeRepositoryImp homeRepositoryImp;
 late MockHomeRemoteDataSource mockHomeRemoteDataSource;
 late List<ProductsEntity> fakeProductsModel;
 setUp(() {
  mockHomeRemoteDataSource = MockHomeRemoteDataSource();
  homeRepositoryImp = HomeRepositoryImp(mockHomeRemoteDataSource);
  provideDummy<ApiResult<List<ProductsEntity>>>(
   ApiFailedResult<List<ProductsEntity>>('Dummy error'),
  );
 });
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
 )]);
group("test getProductsByOCCASIONId in HomeRepositoryImp", (){
  test('should return ApiSuccessResult with products when data source returns success', () async{
    when(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>
        ApiSucessResult<List<ProductsEntity>>(products));
    final result=await homeRepositoryImp.getProductsDetialsByOccasions(occasionId);
    expect(result, isA<ApiSucessResult<List<ProductsEntity>>>());
    expect((result as ApiSucessResult).sucessResult, equals(products));
    verify(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).called(1);
  });
  test('should return ApiFailedResult with null products when data source returns success', () async{
    when(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).thenAnswer((_)async=>
        ApiFailedResult<List<ProductsEntity>>("Products is null"));
    final result=await homeRepositoryImp.getProductsDetialsByOccasions(occasionId);
    expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
    expect((result as ApiFailedResult).errorMessage, equals("Products is null"));
    verify(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).called(1);
  });
  test("should return ApiFailedResult when remote data source fails", ()async{
    when(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId))
        .thenAnswer((_) async => ApiFailedResult<List<ProductsEntity>>('Server error'));
    final result = await homeRepositoryImp.getProductsDetialsByOccasions(occasionId);
    expect(result, isA<ApiFailedResult<List<ProductsEntity>>>());
    expect((result as ApiFailedResult).errorMessage, equals('Server error'));
    verify(mockHomeRemoteDataSource.getProductsDetialsByOccasions(occasionId)).called(1);

  });
});
  group("test getProductsByCategoryId in HomeRepositoryImp", () {
  const  catId = "673c46fd1159920171827c85";
  fakeProductsModel = [
  ProductsEntity(

  id: "673e2e1f1159920171828153",
  title: "Dreamy White Roses Bouquet",

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


  ),
  ProductsEntity(

  id: "6745096c90ab40a0685402fc",
  title: "Forever Pink | Baby Roses",

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


  ),
  ];
  test(
  "when call getProductsByCategoryId in HomeRepositoryImp  with catId  as a parameter it should return api sucess result ",
  () async {
  // arrang
  final mockResult =
  ApiSucessResult<List<ProductsEntity>>(fakeProductsModel);
  provideDummy<ApiResult<List<ProductsEntity>>>(mockResult);

  when(mockHomeRemoteDataSource.getProductsByCategoryId(catId))
      .thenAnswer((_) async => mockResult);

  //act

  final res = await homeRepositoryImp.getProductsByCategoryId(catId);

  //assert

  expect(res, isA<ApiSucessResult<List<ProductsEntity>>>());
  final acResult = res as ApiSucessResult<List<ProductsEntity>>;
  expect(acResult.sucessResult[0].id, equals(fakeProductsModel[0].id));

  verify(mockHomeRemoteDataSource.getProductsByCategoryId(catId)).called(1);
  });

  test(
  "when call getProductsByCategoryId in HomeRepositoryImp and remote source returns failure, should return ApiFailureResult",
  () async {
  // arrange
  final mockError =
  ApiFailedResult<List<ProductsEntity>>("Network error");
  provideDummy<ApiResult<List<ProductsEntity>>>(mockError);

  when(mockHomeRemoteDataSource.getProductsByCategoryId(catId))
      .thenAnswer((_) async => mockError);

  // act
  final res = await homeRepositoryImp.getProductsByCategoryId(catId);

  // assert
  expect(res, isA<ApiFailedResult<List<ProductsEntity>>>());
  final failResult = res as ApiFailedResult<List<ProductsEntity>>;
  expect(failResult.errorMessage, equals("Network error"));
  verify(mockHomeRemoteDataSource.getProductsByCategoryId(catId))
      .called(1);
  },
  );
  });


}
