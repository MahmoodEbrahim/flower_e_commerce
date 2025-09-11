import 'package:flutter/material.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';
import 'package:flower_e_commerce/core/utils/json_helpers/hex_to_color.dart';
import 'package:flower_e_commerce/core/utils/json_helpers/parse_font_weight.dart';
import 'package:flower_e_commerce/core/utils/json_helpers/parse_text_style.dart';

class JsonSectionBuilder extends StatelessWidget {
  final GenericJsonSectionEntity section;
  final String currentLang;

  const JsonSectionBuilder({
    super.key,
    required this.section,
    required this.currentLang,
  });

  // تحول أي قيمة من JSON إلى String
  String extractContent(dynamic value) {
    if (value == null) return '';
    if (value is String) return value;
    if (value is List) return value.map((e) => e.toString()).join("\n\n");
    if (value is Map) return value.values.map((e) => e.toString()).join("\n\n");
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final title = extractContent(section.title?[currentLang]);
    final content = extractContent(section.content[currentLang]);

    final style = section.style;

    final color = hexToColor(style['color'] ?? '#000000');
    final fontSize =
        double.tryParse(style['fontSize']?.toString() ?? '16') ?? 16;
    final fontWeight = parseFontWeight(style['fontWeight'] ?? 'normal');

    final rawAlign = style['textAlign'];
    String alignValue;
    if (rawAlign is Map) {
      alignValue = rawAlign[currentLang] ?? 'left';
    } else {
      alignValue = rawAlign?.toString() ?? 'left';
    }
    final align = parseTextAlign(alignValue);

    return Column(
      crossAxisAlignment: align == TextAlign.right
          ? CrossAxisAlignment.end
          : align == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              fontSize: fontSize + 2,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: align,
          ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
          textAlign: align,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
