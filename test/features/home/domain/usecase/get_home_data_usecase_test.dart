import 'package:flower_e_commerce/features/home/domain/usecase/home_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce/features/home/domain/repository/home_repository.dart';
import 'package:flower_e_commerce/features/home/data/models/homemodel.dart';

import 'get_home_data_usecase_test.mocks.dart';


@GenerateMocks([HomeRepository])
void main() {
  late GetHomeDataUseCase usecase;
  late MockHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockHomeRepository();
    usecase = GetHomeDataUseCase(mockRepository);
  });

  group('GetHomeDataUseCase Tests', () {
    test('should return HomeModel when repository returns success', () async {
      // Arrange
      final homeData = Homemodel(
        categories: [],
        products: [],
        bestSeller: [],
        occasions: [],
      );

      when(mockRepository.getHomeData())
          .thenAnswer((_) async => homeData);

      // Act
      final result = await usecase();

      // Assert
      expect(result, isA<Homemodel>());
      expect(result.categories, isEmpty);
    });

    test('should throw exception when repository fails', () async {
      // Arrange
      when(mockRepository.getHomeData())
          .thenThrow(Exception("Failed to fetch"));

      // Act
      final call = usecase;

      // Assert
      expect(() => call(), throwsException);
    });
  });
}
