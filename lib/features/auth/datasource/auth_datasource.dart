import 'package:firebase_auth/firebase_auth.dart';
import 'package:our_pass/core/services/local_storage.dart';
import 'package:our_pass/di.dart';
import 'package:our_pass/utils/notification_util.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> handleSignInEmail(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = auth.currentUser!;
      await sl<LocalStorage>().clearCachedUserData();
      //Note: username is 0 and email is 1
      await sl<LocalStorage>()
          .cacheUserData([user.displayName ?? '', user.email ?? '']);
      await sl<LocalStorage>().cachePassword(password);
      return user;
    } catch (e) {
      showErrorNotification(e.toString().split("]").last);
    }
    return null;
  }

  Future<User?> handleSignUp(email, password, userName) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser!.updateDisplayName(userName);

      final User user = auth.currentUser!;
      await sl<LocalStorage>().clearCachedUserData();
      //Note: username is 0 and email is 1
      await sl<LocalStorage>()
          .cacheUserData([user.displayName ?? '', user.email ?? '']);
      await sl<LocalStorage>().cachePassword(password);
      return user;
    } catch (e) {
      showErrorNotification(e.toString().split("]").last);
    }
    return null;
  }

  Future<void> handleSignOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      showErrorNotification('Something went wrong!');
    }
  }
}
