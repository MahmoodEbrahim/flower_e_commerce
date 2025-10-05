import 'package:flower_e_commerce/core/utils/constants/json_keys.dart';
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

  Map<String, dynamic> getStyle(
    Map<String, dynamic>? style, {
    bool isTitle = false,
  }) {
    if (style == null) return {};
    if (isTitle && style[JsonKeys.title] is Map) return style[JsonKeys.title];
    if (!isTitle && style[JsonKeys.content] is Map) {
      return style[JsonKeys.content];
    }
    return style;
  }

  @override
  Widget build(BuildContext context) {
    final title = section.title?[currentLang];
    final content = section.content[currentLang];

    //  style title
    final titleStyle = getStyle(section.style, isTitle: true);
    final titleColor = hexToColor(titleStyle[JsonKeys.color] ?? '#000000');
    final titleFontSize =
        double.tryParse(titleStyle[JsonKeys.fontSize]?.toString() ?? '18') ??
        18;
    final titleFontWeight = parseFontWeight(
      titleStyle[JsonKeys.fontWeight] ?? 'normal',
    );
    final rawTitleAlign = titleStyle[JsonKeys.textAlign];
    final titleAlign = parseTextAlign(
      (rawTitleAlign is Map
              ? rawTitleAlign[currentLang]
              : rawTitleAlign?.toString()) ??
          'left',
    );

    //  style content
    final contentStyle = getStyle(section.style);
    final contentColor = hexToColor(contentStyle[JsonKeys.color] ?? '#000000');
    final contentFontSize =
        double.tryParse(contentStyle[JsonKeys.fontSize]?.toString() ?? '16') ??
        16;
    final contentFontWeight = parseFontWeight(
      contentStyle[JsonKeys.fontWeight] ?? 'normal',
    );
    final rawContentAlign = contentStyle[JsonKeys.textAlign];
    final contentAlign = parseTextAlign(
      (rawContentAlign is Map
              ? rawContentAlign[currentLang]
              : rawContentAlign?.toString()) ??
          'left',
    );

    return Column(
      crossAxisAlignment:
          titleAlign == TextAlign.center || contentAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: titleFontWeight,
              color: titleColor,
            ),
            textAlign: titleAlign,
          ),

        if (title != null) const SizedBox(height: 8),
        if (content != null)
          Text(
            content,
            style: TextStyle(
              fontSize: contentFontSize,
              fontWeight: contentFontWeight,
              color: contentColor,
            ),
            textAlign: contentAlign,
          ),
        if (content != null) const SizedBox(height: 25),
      ],
    );
  }
}
