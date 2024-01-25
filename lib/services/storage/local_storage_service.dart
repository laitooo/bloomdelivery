import 'dart:convert';

import 'package:bloomdeliveyapp/business_logic/models/profile/profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';

class LocalStorageService {
  static const sharedPrefTokenKey = 'token';
  static const sharedPrefCurrentUserKey = 'current_user_key';
  static const sharedPrefMyProfileKey = 'my_profile_key';
  static const sharedPrefLastCacheTimeKey = 'cache_time_key';

  Future saveToken(String token) {
    return _saveToPreferences(sharedPrefTokenKey, token);
  }

  Future<String> getToken() {
    return _getStringFromPreferences(sharedPrefTokenKey);
  }

  Future<User> getCurrentUser() async {
    return User.fromJson(
        jsonDecode(await _getStringFromPreferences(sharedPrefCurrentUserKey)));
  }

  Future saveCurrentUser(String user) {
    return _saveToPreferences(sharedPrefCurrentUserKey, user);
  }

  Future<bool> isLoggenIn() async {
    return await getToken().then((value) => value.isNotEmpty);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> _getStringFromPreferences(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return Future<String>.value(prefs.getString(key) ?? '');
  }

  Future<void> _resetCacheTimeToNow() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(sharedPrefLastCacheTimeKey, timestamp);
  }

  Future<Profile?> getMyProfile() async {
    var json = await _getStringFromPreferences(sharedPrefMyProfileKey);
    return json.isNotEmpty ? Profile.fromJson(jsonDecode(json)) : null;
  }

  Future saveMyProfile(String profile) {
    return _saveToPreferences(sharedPrefMyProfileKey, profile);
  }

  void removeCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(sharedPrefCurrentUserKey);
  }

  void removeMyProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(sharedPrefMyProfileKey);
  }

  void removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(sharedPrefTokenKey);
  }
}
