part of 'generic_json_section_bloc.dart';

@immutable
 class GenericJsonSectionStata extends Equatable{
  final RequestState requestState;
  final List<GenericJsonSectionEntity> sections;
  final String errorMessage;

 const GenericJsonSectionStata({
    this.requestState = RequestState.init,
    this.sections=const [],
    this.errorMessage=''
  });

  GenericJsonSectionStata copyWith({
    RequestState? requestState,
    List<GenericJsonSectionEntity>? sections,
    String? errorMessage
  }){
    return GenericJsonSectionStata(
      requestState: requestState??this.requestState,
      sections: sections??this.sections,
      errorMessage: errorMessage??this.errorMessage
    );
  }

  @override
  List<Object?> get props => [requestState, sections, errorMessage];
}

