import 'package:flower_e_commerce/core/utils/json_helpers/json_loader.dart';
import 'package:flower_e_commerce/features/profile/api/source/local/profile_local_data_source_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_local_data_source_imp_test.mocks.dart';

@GenerateMocks([JsonLoader])
void main() {
  late ProfileLocalDataSourceImp dataSource;
  late MockJsonLoader mockJsonLoader;

  setUpAll(() {
    mockJsonLoader = MockJsonLoader();
    dataSource = ProfileLocalDataSourceImp(mockJsonLoader);
  });

  group('ProfileLocalDataSourceImp.getJsonSections', () {
    test(
      'should return LocalDsSucessResult when json loaded successfully',
      () async {
        // arrange
        final jsonMap = {
          'about': [
            {
              'section': 'about',
              'title': {'en': 'About', 'ar': 'عن التطبيق'},
              'content': {'en': 'App info', 'ar': 'معلومات التطبيق'},
            },
          ],
        };
        when(mockJsonLoader.loadJson(any)).thenAnswer((_) async => jsonMap);

        // act
        final result = await dataSource.getJsonSections('dummy_path', 'about');

        // assert
        expect(
          result,
          isA<LocalDsSucessResult<List<GenericJsonSectionEntity>>>(),
        );
        final success =
            result as LocalDsSucessResult<List<GenericJsonSectionEntity>>;
        expect(success.sucessResult.length, 1);
        expect(success.sucessResult.first.section, 'about');
        expect(success.sucessResult.first.title?['en'], 'About');
        expect(success.sucessResult.first.content['ar'], 'معلومات التطبيق');
        verify(mockJsonLoader.loadJson(any)).called(1);
      },
    );

    test('should return LocalDsFailedResult when exception occurs', () async {
      // arrange
      when(mockJsonLoader.loadJson(any)).thenThrow(Exception("file not found"));

      // act
      final result = await dataSource.getJsonSections('dummy_path', 'about');

      // assert
      expect(result, isA<LocalDsFailedResult>());
      final fail = result as LocalDsFailedResult;
      expect(fail.errorMessage, contains('file not found'));
      verify(mockJsonLoader.loadJson(any)).called(1);
    });
  });
}
