import 'package:hive/hive.dart';
import '../../domain/entity/login_entity.dart';

class UserLocalStorage {
  static const String boxName = "user_box";

  static Future<void> init() async {
    await Hive.openBox<LoginEntity>(boxName);
  }

  static Future<void> saveUser(LoginEntity user) async {
    var box = Hive.box<LoginEntity>(boxName);
    await box.put('user', user);
    print("user saved successfully👍👍👍👍👍👍");
  }

  static LoginEntity? getUser() {
    var box = Hive.box<LoginEntity>(boxName);
    return box.get('user');
  }

  static Future<void> clearUser() async {
    var box = Hive.box<LoginEntity>(boxName);
    await box.delete('user');
  }

  static bool isLoggedIn() {
    var box = Hive.box<LoginEntity>(boxName);
    return box.containsKey('user');
  }
}
