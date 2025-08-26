import 'package:flower_e_commerce/features/home/data/models/bestseller_model.dart';
import 'package:flower_e_commerce/features/home/data/models/categories_model.dart';
import 'package:flower_e_commerce/features/home/data/models/occasions_model.dart';
import 'package:flower_e_commerce/features/home/data/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/data/models/home_model.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
  });

  group("HomeRemoteDataSource Test", () {
    test("should return Homemodel when API call succeeds", () async {
      // Arrange
      final mockResponse = Homemodel(
        categories: [CategoriesModel(id: "1", name: "Flowers", image: "flowers.png")],
        products: [ProductsModel(id: "101", title: "Rose", price: 50, imgCover: "rose.png")],
        bestSeller: [BestSellerModel(id: "201", title: "Tulip", price: 70, imgCover: "tulip.png")],
        occasions: [OccasionsModel(id: "301", name: "Birthday", image: "birthday.png")],
      );

      when(mockRemoteDataSource.getHomeData())
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await mockRemoteDataSource.getHomeData();

      // Assert
      expect(result, isA<Homemodel>());
      expect(result.categories?.first.name, "Flowers");
      expect(result.products?.first.title, "Rose");
    });

    test("should throw exception when API call fails", () async {
      // Arrange
      when(mockRemoteDataSource.getHomeData())
          .thenThrow(Exception("Failed to fetch"));

      // Act
      final call = mockRemoteDataSource.getHomeData;

      // Assert
      expect(() => call(), throwsException);
    });
  });
}
