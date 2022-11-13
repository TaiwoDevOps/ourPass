import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_pass/utils/notification_util.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> handleSignInEmail(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;

      return user;
    } catch (e) {
      showErrorNotification(e.toString().split("]").last);
    }
    return null;
  }

  Future<User?> handleSignUp(email, password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User user = result.user!;

      return user;
    } catch (e) {
      showErrorNotification(e.toString().split("]").last);
    }
    return null;
  }
}
