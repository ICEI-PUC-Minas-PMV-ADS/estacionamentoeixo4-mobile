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
}
