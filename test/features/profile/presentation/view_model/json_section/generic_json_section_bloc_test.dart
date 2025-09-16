import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/generate_json_section_usecase.dart';
import 'package:flower_e_commerce/features/profile/presentation/view_model/json_section/generic_json_section_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'generic_json_section_bloc_test.mocks.dart';

@GenerateMocks([GenerateJsonSectionsUseCase])
void main() {
  late GenericJsonSectionBloc genericJsonSectionBloc;
  late MockGenerateJsonSectionsUseCase mockGenerateJsonSectionsUseCase;

  setUp(() {
    provideDummy<LocalDsResult<List<GenericJsonSectionEntity>>>(
      LocalDsFailedResult<List<GenericJsonSectionEntity>>("error"),
    );
    mockGenerateJsonSectionsUseCase = MockGenerateJsonSectionsUseCase();
    genericJsonSectionBloc = GenericJsonSectionBloc(
      mockGenerateJsonSectionsUseCase,
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

  group("generate josn section bloc test", () {
    blocTest<GenericJsonSectionBloc, GenericJsonSectionStata>(
      'emits [loading, success] when json file loaded succeeds',
      build: () {
        when(
          mockGenerateJsonSectionsUseCase.call(any, any),
        ).thenAnswer((_) async => LocalDsSucessResult([jsonSectionEntity]));
        return genericJsonSectionBloc;
      },
      act: (bloc) => bloc.add(GenerateJsonSectionsEvent("jsonPath", "jsonKey")),
      expect: () => [
        GenericJsonSectionStata(requestState: RequestState.loading),
        GenericJsonSectionStata(
          requestState: RequestState.success,
          sections: [jsonSectionEntity],
        ),
      ],
    );

    blocTest<GenericJsonSectionBloc, GenericJsonSectionStata>(
      'emits [loading, error] when error occurred',
      build: () {
        when(mockGenerateJsonSectionsUseCase.call(any, any)).thenAnswer(
          (_) async => LocalDsFailedResult<List<GenericJsonSectionEntity>>(
            "errorMessage",
          ),
        );
        return genericJsonSectionBloc;
      },
      act: (bloc) => bloc.add(GenerateJsonSectionsEvent("jsonPath", "jsonKey")),
      expect: () => [
        GenericJsonSectionStata(requestState: RequestState.loading),
        GenericJsonSectionStata(
          requestState: RequestState.error,
          errorMessage: "errorMessage",
        ),
      ],
    );
  });
}
