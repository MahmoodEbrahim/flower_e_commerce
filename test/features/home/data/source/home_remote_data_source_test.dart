import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

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
        categories: [Categories(id: "1", name: "Flowers", image: "flowers.png")],
        products: [Products(id: "101", title: "Rose", price: 50, imgCover: "rose.png")],
        bestSeller: [BestSeller(id: "201", title: "Tulip", price: 70, imgCover: "tulip.png")],
        occasions: [Occasions(id: "301", name: "Birthday", image: "birthday.png")],
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
