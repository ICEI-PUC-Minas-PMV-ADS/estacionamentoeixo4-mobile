import 'package:firebase_auth/firebase_auth.dart';

class LoginService {
  static Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('loginWithEmailAndPassword.error: $e');
    }
  }

  static Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
    } catch (e) {
      throw Exception('signUpWithEmailAndPassword.error: $e');
    }
  }
}
