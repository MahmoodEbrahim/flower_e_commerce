import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/core/local_ds_result/local_ds_result.dart';
import 'package:flower_e_commerce/core/request_state/request_state.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/features/profile/domain/usecase/generate_json_section_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
part 'generic_json_section_event.dart';
part 'generic_json_section_state.dart';

@injectable
class GenericJsonSectionBloc extends Bloc<GenericJsonSectionEvent, GenericJsonSectionStata> {
  final GenerateJsonSectionsUseCase _generateJsonSectionsUseCase;

  GenericJsonSectionBloc(this._generateJsonSectionsUseCase) : super(const GenericJsonSectionStata()) {
    on<GenerateJsonSectionsEvent>(_onGetAboutAppSections);
  }

  Future<void> _onGetAboutAppSections(
      GenerateJsonSectionsEvent event,
      Emitter<GenericJsonSectionStata> emit,
      ) async {
    emit(state.copyWith(requestState: RequestState.loading));

    final result = await _generateJsonSectionsUseCase(event.jsonPath,event.jsonKey);

    switch(result){
      case LocalDsSucessResult<List<GenericJsonSectionEntity>>():
        emit(state.copyWith(
                requestState: RequestState.success,
                sections: result.sucessResult,
              ));

      case LocalDsFailedResult<List<GenericJsonSectionEntity>>():
    emit(state.copyWith(
          requestState: RequestState.error,
          errorMessage: result.errorMessage,
        ));
    }
  }
}
