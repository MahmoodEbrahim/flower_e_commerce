import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/api_result/api_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/generate_json_section_sections_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
part 'generic_json_section_event.dart';
part 'generic_json_section_state.dart';

@injectable
class GenericJsonSectionBloc extends Bloc<GenericJsonSectionEvent, GenericJsonSectionStata> {
  final GenerateJsonSectionsUseCase _generateJsonSectionsUseCase;

  GenericJsonSectionBloc(this._generateJsonSectionsUseCase) : super(const GenericJsonSectionStata()) {
    on<GenerateJsonSections>(_onGetAboutAppSections);
  }

  Future<void> _onGetAboutAppSections(
      GenerateJsonSections event,
      Emitter<GenericJsonSectionStata> emit,
      ) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _generateJsonSectionsUseCase(event.jsonPath,event.jsonKey);

    switch(result){
      case ApiSucessResult<List<GenericJsonSectionEntity>>():
        emit(state.copyWith(
                requestState: RequestState.success,
                sections: result.sucessResult,
              ));

      case ApiFailedResult<List<GenericJsonSectionEntity>>():
    emit(state.copyWith(
          requestState: RequestState.error,
          errorMessage: result.errorMessage,
        ));
    }
  }
}
