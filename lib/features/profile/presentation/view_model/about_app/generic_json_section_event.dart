part of 'generic_json_section_bloc.dart';

@immutable
abstract class GenericJsonSectionEvent extends Equatable {
  const GenericJsonSectionEvent();
  List<Object?> get props => [];
}

class GenerateJsonSections extends GenericJsonSectionEvent {
  String jsonPath;
   String jsonKey;
   GenerateJsonSections(this.jsonPath,this.jsonKey);
}
