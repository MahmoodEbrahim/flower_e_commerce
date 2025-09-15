import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/features/profile/domain/repository/profile_repository.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/generate_json_section_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'generate_json_section_usecase_test.mocks.dart';

@GenerateMocks([ProfileRepository])
void main() {
  late GenerateJsonSectionsUseCase generateJsonSectionsUseCase;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    provideDummy<LocalDsResult<List<GenericJsonSectionEntity>>>(
      LocalDsFailedResult<List<GenericJsonSectionEntity>>("error"),
    );
    mockProfileRepository = MockProfileRepository();
    generateJsonSectionsUseCase = GenerateJsonSectionsUseCase(
      mockProfileRepository,
    );
  });

  GenericJsonSectionEntity jsonSectionEntity = GenericJsonSectionEntity(
    section: 'about',
    title: {'en': 'About', 'ar': 'عن التطبيق'},
    content: {'en': 'App info', 'ar': 'معلومات التطبيق'},
    style: {
      "fontSize": 24,
      "fontWeight": "bold",
      "color": "#D21E6A",
      "textAlign": {"en": "center", "ar": "center"},
    },
  );

  group("test generate json section use case test", () {
    test(
      "should return LocalDsSucessResult when json loaded successfully",
      () async {
        when(
          mockProfileRepository.getJsonSections(any, any),
        ).thenAnswer((_) async => LocalDsSucessResult([jsonSectionEntity]));
        final result = await generateJsonSectionsUseCase.call(
          "jsonPath",
          "jsonKey",
        );
        expect(
          result,
          isA<LocalDsSucessResult<List<GenericJsonSectionEntity>>>(),
        );
        final success =
            result as LocalDsSucessResult<List<GenericJsonSectionEntity>>;
        expect(success.sucessResult.length, 1);
        expect(success.sucessResult.first.content, {
          'en': 'App info',
          'ar': 'معلومات التطبيق',
        });
        verify(mockProfileRepository.getJsonSections(any, any)).called(1);
      },
    );

    test('should return LocalDsFailedResult when exception occurs', () async {
      when(
        mockProfileRepository.getJsonSections(any, any),
      ).thenAnswer((_) async => LocalDsFailedResult("file not found"));

      final result = await generateJsonSectionsUseCase.call(
        "jsonPath",
        "jsonKey",
      );

      expect(
        result,
        isA<LocalDsFailedResult<List<GenericJsonSectionEntity>>>(),
      );
      final fail =
          result as LocalDsFailedResult<List<GenericJsonSectionEntity>>;
      expect(fail.errorMessage, isNotEmpty);
      expect(fail.errorMessage, contains("file not found"));
      verify(mockProfileRepository.getJsonSections(any, any)).called(1);
    });
  });
}
