import 'package:hive/hive.dart';
import '../../domain/entity/login_model.dart';

class UserLocalStorage {
  static const String boxName = "user_box";
  static const String tokenKey = "Authorization";
  static const String languageBox = "language_box";
  static const String languageKey = "language";
  static Future<void> init() async {
    await Hive.openBox<LoginModel>(boxName);
    await Hive.openBox<String>(tokenKey);
    await Hive.openBox<String>(languageBox);

  }

  static Future<void> saveUser(LoginModel user) async {
    var box = Hive.box<LoginModel>(boxName);
    await box.put('user', user);

  }

  static LoginModel? getUser() {
    var box = Hive.box<LoginModel>(boxName);
    return box.get('user');
  }
  static Future<void>saveToken(String token)async{
    var box=Hive.box<String>(tokenKey);
    await box.put(tokenKey, token  );
  }
  static String? getToken(){
    var box = Hive.box<String>(tokenKey);
    return  box.get(tokenKey);
  }
  static Future<void> clearToken() async {
    var box = Hive.box<String>(tokenKey);
    await box.delete(tokenKey);
  }

  static Future<void> clearUser() async {
    var box = Hive.box<LoginModel>(boxName);
    await box.delete('user');
  }

  static bool isLoggedIn() {
    var box = Hive.box<LoginModel>(boxName);
    return box.containsKey('user');
  }
  static Future<void> saveLanguage(String language) async {
    var box = Hive.box<String>(languageBox);
    await box.put(languageKey, language);
  }
  static Future<String?> getLanguage() async {
    var box = Hive.box<String>(languageBox);
    return box.get(languageKey);
  }
}
