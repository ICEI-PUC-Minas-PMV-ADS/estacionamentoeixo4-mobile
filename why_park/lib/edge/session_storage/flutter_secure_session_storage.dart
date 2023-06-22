import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:why_park/edge/session_storage/session_storage.dart';

class FlutterSecureSessionStorage implements SessionStorage {
  final storage = const FlutterSecureStorage();

  @override
  Future<String?> retrieveSession() async {
    return await storage.read(key: 'token');
  }

  @override
  Future<void> saveSession(String token) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<String?> retrieveEmail() async {
    return await storage.read(key: 'email');
  }

  @override
  Future<void> saveEmail(String name) async {
    await storage.write(key: 'email', value: name);
  }

  @override
  Future<String?> retrieveUserName() async {
    final String key = await retrieveEmail() ?? '';
    return await storage.read(key: key);
  }

  @override
  Future<void> saveUserName(String key, String name) async {
    await storage.write(key: key, value: name);
  }

  @override
  Future<void> clear() async {
    await storage.deleteAll();
  }

  @override
  Future<String?> retrieveId() async {
    return await storage.read(key: 'id');
  }

  @override
  Future<void> saveClientId(String id) async {
    await storage.write(key: 'id', value: id);
  }
}
