abstract class UserLocalStorage {
  Future<void> init();

  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<bool> isLoggedIn();

  Future<void> saveLanguage(String language);
  Future<String?> getLanguage();
}
