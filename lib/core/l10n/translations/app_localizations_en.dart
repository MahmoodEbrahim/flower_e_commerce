// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get egp => 'EGP';

  @override
  String get status => 'Status: ';

  @override
  String get inStock => 'In stock';

  @override
  String get outOfStock => 'Out of stock';

  @override
  String get includeTax => 'All prices include tax';

  @override
  String get description => 'Description';

  @override
  String get addToCart => 'Add to cart';
}
