// local persistence
import 'package:shared_preferences/shared_preferences.dart';

const kToken = 'token';
const kPassword = 'password';
const kUser = 'user';

abstract class LocalStorage {
  Future<void> cacheToken(String? token);
  String? getToken();

  Future<void> cachePassword(String? password);
  String getPassword();

  Future<bool> clearCachedUserData();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl(this.sharedPreferences);
  SharedPreferences sharedPreferences;

  @override
  Future<void> cacheToken(String? token) async {
    if (token == null) {
      await sharedPreferences.remove(kToken);
    } else {
      await sharedPreferences.setString(kToken, token);
    }
  }

  @override
  String? getToken() {
    return sharedPreferences.getString(kToken);
  }

  @override
  Future<void> cachePassword(String? password) async {
    if (password == null) {
      await sharedPreferences.remove(kPassword);
    } else {
      await sharedPreferences.setString(kPassword, password);
    }
  }

  @override
  String getPassword() {
    return sharedPreferences.getString(kPassword) ?? '';
  }

  @override
  Future<bool> clearCachedUserData() {
    final userJson = sharedPreferences.remove(kUser);
    return userJson;
  }
}
