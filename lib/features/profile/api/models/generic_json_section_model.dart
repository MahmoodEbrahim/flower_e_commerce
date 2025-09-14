import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';

class GenericJsonSectionModel {
  final String section;
  final Map<String, dynamic>? title;
  final Map<String, dynamic>? content;
  final Map<String, dynamic>? style;

  GenericJsonSectionModel({
    required this.section,
    this.title,
    this.content,
    this.style,
  });

  factory GenericJsonSectionModel.fromJson(Map<String, dynamic> json) {
    return GenericJsonSectionModel(
      section: json['section'] ?? '',
      // map.from --> convert from json to dart map
      title: json['title'] != null ? Map<String, dynamic>.from(json['title']) : null,
      content: json['content'] != null ? Map<String, dynamic>.from(json['content']) : null,
      style: json['style'] != null ? Map<String, dynamic>.from(json['style']) : null,
    );
  }

  GenericJsonSectionEntity toEntity() {

    return GenericJsonSectionEntity(
      section: section,
      title: normalizeMap(title),
      content: normalizeMap(content),
      style: style ?? {},
    );
  }
}
// convert any value to string --> to not handel them in ui
String normalizeValue(dynamic value) {
  if (value == null) return '';
  if (value is String) return value;
  if (value is List) return value.map((e) => e.toString()).join("\n\n");
  if (value is Map) return value.values.map((e) => e.toString()).join("\n\n");
  return value.toString();
}

//convert map to map of string , dynamic
Map<String, String> normalizeMap(Map<String, dynamic>? raw) {
  if (raw == null) return {};
  return raw.map((key, value) => MapEntry(key, normalizeValue(value)));
}