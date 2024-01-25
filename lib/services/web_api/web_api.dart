import 'dart:io';

import 'package:bloomdeliveyapp/business_logic/models/profile/profile_model.dart';

abstract class WebApi {
  Future login(String identifier, String password);
  Future searchProfiles(String q);
  Future getProfileById(String id);
  Future getProfileByUser(String id);
  Future updateProfile(Profile profile);
  Future updateProfileImage(Profile profile, File profileImage);
}
