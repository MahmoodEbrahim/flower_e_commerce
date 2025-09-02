import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce/features/profile/api/models/generic_section_model.dart';
import 'package:flower_e_commerce/core/utils/constants/json_keys.dart';

void main() {
  group('GenericSectionModel', () {
    test('should parse valid JSON correctly', () {
      final json = {
        JsonKeys.section: 'about',
        JsonKeys.title: {
          JsonKeys.en: 'About Us',
          JsonKeys.ar: 'معلومات عنا',
        },
        JsonKeys.content: {
          JsonKeys.en: 'Welcome to our app',
          JsonKeys.ar: 'مرحبًا بكم في تطبيقنا',
        },
        JsonKeys.style: {
          JsonKeys.fontSize: 16,
          JsonKeys.color: '#000000',
        }
      };

      final model = GenericSectionModel.fromJson(json);

      expect(model.section, 'about');
      expect(model.titleEn, 'About Us');
      expect(model.titleAr, 'معلومات عنا');
      expect(model.contentEn, 'Welcome to our app');
      expect(model.contentAr, 'مرحبًا بكم في تطبيقنا');
      expect(model.style[JsonKeys.fontSize], 16);
    });

    test('should handle missing optional fields', () {
      final json = {
        JsonKeys.section: 'about',
        JsonKeys.style: {},
      };

      final model = GenericSectionModel.fromJson(json);

      expect(model.section, 'about');
      expect(model.titleEn, isNull);
      expect(model.contentEn, isNull);
      expect(model.style, {});
    });

    test('should parse list content correctly', () {
      final json = {
        JsonKeys.section: 'terms',
        JsonKeys.content: {
          JsonKeys.en: ['Item 1', 'Item 2'],
          JsonKeys.ar: ['البند 1', 'البند 2'],
        },
        JsonKeys.style: {},
      };

      final model = GenericSectionModel.fromJson(json);

      expect(model.contentEn, isA<List>());
      expect(model.contentEn, ['Item 1', 'Item 2']);
      expect(model.contentAr, ['البند 1', 'البند 2']);
    });


  });

}
