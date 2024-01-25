import 'package:bloomdeliveyapp/business_logic/models/profile/profile_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';

abstract class StorageService {
  Future saveToken(String token);
  Future saveMyProfile(String profile);
  Future<String> getToken();

  Future<User> getCurrentUser();
  Future<Profile?> getMyProfile();

  Future saveCurrentUser(String user);

  Future<bool> isLoggenIn();

  void removeToken();
  void removeCurrentUser();
  void removeMyProfile();
}
