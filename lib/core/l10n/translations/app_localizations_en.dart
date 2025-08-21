// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get password => 'Password';

  @override
  String get enterYourPassword => 'Enter your password';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get forgetPassword => 'Forget password?';

  @override
  String get loginSuccess => 'Login Success ✅';

  @override
  String get serverError => 'server error , try again';

  @override
  String get continueAsGuest => 'Continue as guest';

  @override
  String get donotHaveAccount => 'Don\'t have an account? ';

  @override
  String get signUp => 'Sign up';
}
