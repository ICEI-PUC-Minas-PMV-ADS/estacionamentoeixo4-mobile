abstract class SessionStorage {
  Future<void> saveSession(final String token);

  Future<String?> retrieveSession();

  Future<void> saveClientId(final String id);

  Future<String?> retrieveId();

  Future<String?> retrieveEmail();

  Future<void> saveEmail(String name);

  Future<String?> retrieveUserName();

  Future<void> saveUserName(String key, String name);

  Future<void> clear();
}
