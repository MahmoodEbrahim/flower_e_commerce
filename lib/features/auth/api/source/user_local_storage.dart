import 'package:flower_e_commerce/features/address/domain/entity/adress_entity.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:hive/hive.dart';
import '../../domain/entity/login_model.dart';

// class UserLocalStorage {
//   static const String boxName = "user_box";
//   static const String tokenKey = "Authorization";
//   static const String languageBox = "language_box";
//   static const String languageKey = "language";
//   static const String addressBox = "address_box";
//   static const String addressKey = "address";
//
//   static Future<void> init() async {
//     await Hive.openBox<LoginModel>(boxName);
//     await Hive.openBox<String>(tokenKey);
//     await Hive.openBox<String>(languageBox);
//     await Hive.openBox<List<AddressEntity>>(addressBox);
//   }
//
//   static Future<void> saveUser(LoginModel user) async {
//     var box = Hive.box<LoginModel>(boxName);
//     await box.put('user', user);
//
//   }
//   static Future<void> updateUserAddress
//       (List<AddressEntity> addresses) async {
//  final user= getUser();
//
//     final userAddress=user!.user.copyWith(
//       addresses: addresses
//     );
//
// saveUser(user.copyWith(
//   user: userAddress
// ));
//   }
// //   static Future<void> updateUserAddress(List<AddressEntity> addresses) async {
// //     final user = getUser();
// //     if (user != null && user.user != null) {
// //       final updatedUser = user.user!.copyWith(addresses: addresses);
// //       await saveUser(user.copyWith(user: updatedUser));
// //     }
// //   }
//   static LoginModel? getUser() {
//     var box = Hive.box<LoginModel>(boxName);
//     return box.get('user');
//   }
//   static Future<void>saveToken(String token)async{
//     var box=Hive.box<String>(tokenKey);
//     await box.put(tokenKey, token  );
//   }
//   static String? getToken(){
//     var box = Hive.box<String>(tokenKey);
//     return  box.get(tokenKey);
//   }
//   static Future<void> clearToken() async {
//     var box = Hive.box<String>(tokenKey);
//     await box.delete(tokenKey);
//   }
//
//   static Future<void> clearUser() async {
//     var box = Hive.box<LoginModel>(boxName);
//     await box.delete('user');
//   }
//
//   static bool isLoggedIn() {
//     var box = Hive.box<LoginModel>(boxName);
//     return box.containsKey('user');
//   }
//   static Future<void> saveLanguage(String language) async {
//     var box = Hive.box<String>(languageBox);
//     await box.put(languageKey, language);
//   }
//   static Future<String?> getLanguage() async {
//     var box = Hive.box<String>(languageBox);
//     return box.get(languageKey);
//   }
// }


class UserLocalStorage {
  static const String boxName = "user_box";        // box للـ LoginModel
  static const String tokenBox = "token_box";      // box للـ token
  static const String languageBox = "language_box"; // box للغة

  static Future<void> init() async {
    await Hive.openBox<LoginModel>(boxName);
    await Hive.openBox<String>(tokenBox);
    await Hive.openBox<String>(languageBox);
  }

  /// حفظ بيانات اليوزر
  static Future<void> saveUser(LoginModel user) async {
    var box = Hive.box<LoginModel>(boxName);
    await box.put('user', user);
  }

  /// تحديث عناوين اليوزر
  static Future<void> updateUserAddress(List<AddressEntity> addresses) async {
    final user = getUser();
    if (user == null) return;

    final updatedUserModel = user.user.copyWith(addresses: addresses);

    await saveUser(
      user.copyWith(user: updatedUserModel),
    );
  }

   static LoginModel? getUser() {
    var box = Hive.box<LoginModel>(boxName);
    return box.get('user');
  }


  static Future<void> saveToken(String token) async {
    var box = Hive.box<String>(tokenBox);
    await box.put('token', token);
  }

  /// استرجاع التوكن
  static String? getToken() {
    var box = Hive.box<String>(tokenBox);
    return box.get('token');
  }

  /// مسح التوكن
  static Future<void> clearToken() async {
    var box = Hive.box<String>(tokenBox);
    await box.delete('token');
  }

  /// مسح بيانات اليوزر
  static Future<void> clearUser() async {
    var box = Hive.box<LoginModel>(boxName);
    await box.delete('user');
  }

  /// هل اليوزر عامل تسجيل دخول؟
  static bool isLoggedIn() {
    var box = Hive.box<LoginModel>(boxName);
    return box.containsKey('user');
  }

  /// حفظ اللغة
  static Future<void> saveLanguage(String language) async {
    var box = Hive.box<String>(languageBox);
    await box.put('language', language);
  }


  static Future<String?> getLanguage() async {
    var box = Hive.box<String>(languageBox);
    return box.get('language');
  }
}
