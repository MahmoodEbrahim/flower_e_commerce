import 'package:hive/hive.dart';
import '../../domain/entity/login_model.dart';

class UserLocalStorage {
  static const String boxName = "user_box";

  static Future<void> init() async {
    await Hive.openBox<LoginModel>(boxName);
  }

  static Future<void> saveUser(LoginModel user) async {
    var box = Hive.box<LoginModel>(boxName);
    await box.put('user', user);
  }

  static LoginModel? getUser() {
    var box = Hive.box<LoginModel>(boxName);
    return box.get('user');
  }

  static Future<void> clearUser() async {
    var box = Hive.box<LoginModel>(boxName);
    await box.delete('user');
  }

  static bool isLoggedIn() {
    var box = Hive.box<LoginModel>(boxName);
    return box.containsKey('user');
  }
}
