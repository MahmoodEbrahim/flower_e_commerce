import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/features/home/domain/entity/product_model.dart';
import 'package:flower_e_commerce/features/home/domain/usecase/get_products_by_category_id._usecase.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_event.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/categories_view_model.dart';
import 'package:flower_e_commerce/features/home/presentation/view_model/categories_view_model/category_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import 'categories_view_model_test.mocks.dart';

@GenerateMocks([GetProductsByCategoryIdUseCase])
void main() {
  late MockGetProductsByCategoryIdUseCase mockGetProductsByCategoryIdUseCase;
  late CategoriesViewModel categoriesViewModel;
  late List<ProductModel> fakeProductsModel;
  late String catId;

  setUpAll(() {
    catId = "673c46fd1159920171827c85";
    mockGetProductsByCategoryIdUseCase = MockGetProductsByCategoryIdUseCase();
    categoriesViewModel =
        CategoriesViewModel(mockGetProductsByCategoryIdUseCase);

    fakeProductsModel = [
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
  });

 
 
  group('test categoryies view model', () {
    blocTest<CategoriesViewModel, CategoryState>(
      'emits states first is loading and second with data when GetAllProductsOfCategoriesEvent is added and products are fetched successfully',
      build: () {
        final mockResult =
            ApiSucessResult<List<ProductModel>>(fakeProductsModel);
        provideDummy<ApiResult<List<ProductModel>>>(mockResult);
        when(mockGetProductsByCategoryIdUseCase.getProductsByCategoryId(catId))
            .thenAnswer((_) async => mockResult);
        return categoriesViewModel;
      },
      act: (bloc) => bloc.add(GetAllProductsOfCategoriesEvent(catId: catId)),
      expect: () => <CategoryState>[
        CategoryState(isLoading: true, errorMessage: null, products: null),
        CategoryState(
            isLoading: false, errorMessage: null, products: fakeProductsModel),
      ],

    // verify: (categoriesViewModel) =>verify(mockGetProductsByCategoryIdUseCase).called(1) ,
   
    );
    
    
    //  blocTest<CategoriesViewModel, CategoryState>(
    //   'emits states first is loading and second with errorMessage when GetAllProductsOfCategoriesEvent is added and products are fetched failed',
    //   build: () {
    //     final mockResult = ApiFailedResult<List<ProductModel>>("errorMessage");
    //     provideDummy<ApiResult<List<ProductModel>>>(mockResult);
    //     when(mockGetProductsByCategoryIdUseCase.getProductsByCategoryId(catId))
    //         .thenAnswer((_) async => mockResult);
    //     return categoriesViewModel;
    //   },
    //   act: (bloc) => bloc.add(GetAllProductsOfCategoriesEvent(catId: catId)),
    //   expect: () => <CategoryState>[
    //     CategoryState(isLoading: true, errorMessage: null, products: null),
    //     CategoryState(
    //         isLoading: false, errorMessage: "errorMessage", products: null),
    //   ],
    //    verify: (categoriesViewModel) =>verify(mockGetProductsByCategoryIdUseCase).called(1) ,
   

    // );



  });


 blocTest<CategoriesViewModel, CategoryState>(
      'emits states first is loading and second with data when GetAllProductsEvent is added and products are fetched successfully',
      build: () {
      
          
        return categoriesViewModel;
      },
      act: (bloc) => bloc.add(GetAllProductsEvent(products: fakeProductsModel)),
      expect: () => <CategoryState>[
        CategoryState(isLoading: true, errorMessage: null, products: null),
        CategoryState(
            isLoading: false, errorMessage: null, products: fakeProductsModel),
      ],

     //verify: (categoriesViewModel) =>verify(mockGetProductsByCategoryIdUseCase).called(1) ,
   
    );
    
    


}
