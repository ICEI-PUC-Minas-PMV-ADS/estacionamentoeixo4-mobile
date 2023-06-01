abstract class SessionStorage {
  Future<void> saveSession(final String token);

  Future<String?> retrieveSession();
}