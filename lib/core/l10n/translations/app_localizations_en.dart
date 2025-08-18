// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get password => 'Password';

  @override
  String get forgetpassword => 'Forget password';

  @override
  String get pleaseenteryouremailassociatedtoyouraccount =>
      'Please enter your email associated to \nyour account';

  @override
  String get thisEmailisnotvalid => 'This Email is not valid';

  @override
  String get email => 'Email';

  @override
  String get confirm => 'Confirm';
}
