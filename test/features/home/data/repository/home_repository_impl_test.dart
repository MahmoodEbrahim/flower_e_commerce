import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';
import 'package:flower_e_commerce/features/home/data/source/home_remote_data_source.dart';
import 'package:flower_e_commerce/features/home/data/repository/home_repository_imp.dart';

class MockHomeRemoteDataSource extends Mock implements HomeRemoteDataSource {}

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  group("HomeRepositoryImpl Test", () {
    test("should return Homemodel when datasource succeeds", () async {
      // Arrange
      final mockResponse = Homemodel(
        categories: [],
        products: [],
        bestSeller: [],
        occasions: [],
      );
      when(mockRemoteDataSource.getHomeData())
          .thenAnswer((_) async => mockResponse);

      // Act
      final result = await repository.getHomeData();

      // Assert
      expect(result, isA<Homemodel>());
      expect(result.categories, []);
    });

    test("should throw exception when datasource fails", () async {
      // Arrange
      when(mockRemoteDataSource.getHomeData())
          .thenThrow(Exception("Failed"));

      // Act
      final call = repository.getHomeData;

      // Assert
      expect(() => call(), throwsException);
    });
  });
}
