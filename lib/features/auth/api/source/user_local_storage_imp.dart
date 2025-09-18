import 'package:flower_e_commerce/features/auth/data/source/user_local_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: UserLocalStorage)
class UserLocalStorageImp implements UserLocalStorage {
  static const String tokenBox = "token_box";
  static const String languageBox = "language_box";

  @override
  Future<void> init() async {
    await Hive.openBox<String>(tokenBox);
    await Hive.openBox<String>(languageBox);
  }

  @override
  Future<void> saveToken(String token) async {
    var box = Hive.box<String>(tokenBox);
    await box.put('token', token);
  }

  @override
  Future<String?> getToken() async {
    var box = Hive.box<String>(tokenBox);
    return box.get('token');
  }

  @override
  Future<void> clearToken() async {
    var box = Hive.box<String>(tokenBox);
    await box.delete('token');
  }

  @override
  Future<bool> isLoggedIn() async {
    var box = Hive.box<String>(tokenBox);
    return box.containsKey('token');
  }

  @override
  Future<void> saveLanguage(String language) async {
    var box = Hive.box<String>(languageBox);
    await box.put('language', language);
  }

  @override
  Future<String?> getLanguage() async {
    var box = Hive.box<String>(languageBox);
    return box.get('language');
  }
}
