import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:hive/hive.dart';
import '../../domain/entity/login_model.dart';

class UserLocalStorage {
  static const String boxName = "user_box";
  static const String tokenKey = "Authorization";
  static const String languageBox = "language_box";
  static const String languageKey = "language";
  static const String addressBox = "address_box";
  static const String addressKey = "address";

  static Future<void> init() async {
    await Hive.openBox<LoginModel>(boxName);
    await Hive.openBox<String>(tokenKey);
    await Hive.openBox<String>(languageBox);
    await Hive.openBox<List<AddressEntity>>(addressBox);
  }

  static Future<void> saveUser(LoginModel user) async {
    var box = Hive.box<LoginModel>(boxName);
    await box.put('user', user);

  }
  static Future<void> updateUserAddress
      (List<AddressEntity> addresses) async {
 final user= getUser();

    final userAddress=user!.user.copyWith(
      addresses: addresses
    );

saveUser(user.copyWith(
  user: userAddress
));
  }
//   static Future<void> updateUserAddress(List<AddressEntity> addresses) async {
//     final user = getUser();
//     if (user != null && user.user != null) {
//       final updatedUser = user.user!.copyWith(addresses: addresses);
//       await saveUser(user.copyWith(user: updatedUser));
//     }
//   }
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
