import 'package:flower_e_commerce/features/profile/api/models/generic_json_section_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/profile/domain/entity/generic_json_section_entity.dart';

void main() {
  group('GenericJsonSectionModel', () {
    test('fromJson should parse correctly', () {
      final json = {
        'section': 'about',
        'title': {'en': 'About', 'ar': 'عن التطبيق'},
        'content': {'en': 'This is about', 'ar': 'هذا عن التطبيق'},
        'style': {'fontWeight': 'bold'},
      };

      final model = GenericJsonSectionModel.fromJson(json);

      expect(model.section, 'about');
      expect(model.title, isNotNull);
      expect(model.title!['en'], 'About');
      expect(model.content!['ar'], 'هذا عن التطبيق');
      expect(model.style!['fontWeight'], 'bold');
    });

    test('toEntity should convert correctly', () {
      final model = GenericJsonSectionModel(
        section: 'terms',
        title: {'en': 'Terms', 'ar': 'الشروط'},
        content: {'en': 'Conditions', 'ar': 'الأحكام'},
        style: {'color': 'red'},
      );

      final entity = model.toEntity();

      expect(entity, isA<GenericJsonSectionEntity>());
      expect(entity.section, 'terms');
      expect(entity.title?['en'], 'Terms');
      expect(entity.content['ar'], 'الأحكام');
      expect(entity.style['color'], 'red');
    });
  });

  group('normalizeValue & normalizeMap', () {
    test('normalizeValue should handle different types', () {
      expect(normalizeValue(null), '');
      expect(normalizeValue('Hello'), 'Hello');
      expect(normalizeValue(123), '123');
      expect(normalizeValue(['a', 'b']), 'a\n\nb');
      expect(normalizeValue({'x': 1, 'y': 2}), '1\n\n2');
    });

    test('normalizeMap should handle maps', () {
      final raw = {
        'en': 'Hello',
        'ar': ['مرحبا', 'اهلا'],
      };
      final normalized = normalizeMap(raw);

      expect(normalized['en'], 'Hello');
      expect(normalized['ar'], 'مرحبا\n\nاهلا');
    });
  });
}
