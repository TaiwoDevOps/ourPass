// local persistence

import 'package:shared_preferences/shared_preferences.dart';

const kPassword = 'password';
const kUser = 'user';

abstract class LocalStorage {
  Future<void> cachePassword(String? password);
  String getPassword();

  Future<void> cacheUserData(List<String>? data);
  List<String>? getCachedUserData();
  Future<bool> clearCachedUserData();
}

class LocalStorageImpl implements LocalStorage {
  LocalStorageImpl(this.sharedPreferences);
  SharedPreferences sharedPreferences;

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
  Future<void> cacheUserData(List<String>? data) async {
    if (data == null) {
      await sharedPreferences.remove(kUser);
    } else {
      //Note: username is 0 and email is 1
      await sharedPreferences.setStringList(kUser, data);
    }
  }

  @override
  List<String>? getCachedUserData() {
    final userJson = sharedPreferences.getStringList(kUser);
    return userJson;
  }

  @override
  Future<bool> clearCachedUserData() {
    final res = sharedPreferences.remove(kUser);
    return res;
  }
}
