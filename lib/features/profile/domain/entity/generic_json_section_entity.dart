class GenericJsonSectionEntity {
  final String section;
  final Map<String, String>? title;
  final Map<String, String> content;
  final Map<String, dynamic> style;

  GenericJsonSectionEntity({
    required this.section,
    this.title,
    required this.content,
    required this.style,
  });
}
