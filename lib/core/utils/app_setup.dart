import 'package:firebase_core/firebase_core.dart';
import 'package:our_pass/utils/log_util.dart';

class AppSetups {
  static Future<void> runSetups() async {
    // init firebase serivce
    await Firebase.initializeApp();

    // init logger
    Log.init();
  }
}
