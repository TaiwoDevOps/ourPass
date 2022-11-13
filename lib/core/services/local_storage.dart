// local persistence
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kToken = 'token';
const kPassword = 'password';
const kUser = 'user';

abstract class LocalStorage {
  Future<void> cachePassword(String? password);
  String getPassword();

  Future<void> cacheUserData(User? data);
  dynamic getCachedUserData();
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
  Future<void> cacheUserData(User? data) async {
    if (data == null) {
      await sharedPreferences.remove(kUser);
    } else {
      await sharedPreferences.setString(kUser, data.toString());
    }
  }

  @override
  dynamic getCachedUserData() {
    final userJson = sharedPreferences.getString(kUser);
    return userJson;
  }

  @override
  Future<bool> clearCachedUserData() {
    final userJson = sharedPreferences.remove(kUser);
    return userJson;
  }
}
