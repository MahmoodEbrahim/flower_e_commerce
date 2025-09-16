part of 'generic_json_section_bloc.dart';

@immutable
abstract class GenericJsonSectionEvent extends Equatable {
  const GenericJsonSectionEvent();
  @override
  List<Object?> get props => [];
}

class GenerateJsonSectionsEvent extends GenericJsonSectionEvent {
  final String jsonPath;
  final String jsonKey;
  const GenerateJsonSectionsEvent(this.jsonPath,this.jsonKey);
  @override
  List<Object?> get props => [jsonPath,jsonKey];
}
