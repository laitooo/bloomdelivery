import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final LocalStorageService _localStorageService =
      serviceLocator<LocalStorageService>();
  static const sharedPrefTokenKey = 'token_key';
  static const sharedPrefCurrentUserKey = 'current_user_key';
  static const sharedPrefMyProfileKey = 'my_profile_key';
  static const sharedPrefLastCacheTimeKey = 'cache_time_key';
  Future<User> getCurrentUser() async {
    return await _localStorageService.getCurrentUser();
  }

  Future<bool> isLoggedIn() async {
    return await _localStorageService
        .getToken()
        .then((token) => token.isNotEmpty);
  }


  Future saveCurrentUser(String user) {
    return _saveToPreferences(sharedPrefCurrentUserKey, user);
  }

  Future<void> _saveToPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }
}
