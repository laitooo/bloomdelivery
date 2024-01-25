import 'dart:convert';
import 'package:bloomdeliveyapp/business_logic/models/profile/profile_model.dart';

import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:http/src/response.dart';

import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/services/web_api/strapi_local_api.dart';

class LoginServiceStrapi {
  StrapiLocalApi _strapiLocalApi = serviceLocator<StrapiLocalApi>();
  final LocalStorageService _storageService =
      serviceLocator<LocalStorageService>();


  late String _token;
  late User _user;

  late Profile _profile;

  Future<User> getCurrentUser() async {
    _user = await _storageService.getCurrentUser();
    return _user;
  }

  /* Future<Response> login(String identifier, String password) async {
    Response response;
    return await _strapiLocalApi
        .login(identifier, password)
        .then((value) async {
      response = value;

      if (value.statusCode == 200) {
        var parsed = jsonDecode(response.body);
        print(jsonEncode(parsed));
         parsed = '{"jwt":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImlhdCI6MTcwNTkzNzQyNywiZXhwIjoxNzA4NTI5NDI3fQ.JYSsjtTzRSHu3W7afFLhE36vrsQwQCGHZyjAy6P_1Nw","user":{"id":17,"username":"910627594","email":"ahmadtibin@gmail.com","provider":"local","confirmed":true,"blocked":false,"createdAt":"2022-06-21T22:43:34.980Z","updatedAt":"2024-01-22T08:42:43.158Z","phone":"910627594","fullname":"Ahmed Ibrahim Tibin","type":"Normal","otp":null,"confirmedPhone":true}}';
        _token = parsed['jwt'];
        _user = User.fromJson(parsed['user']);
        await _saveToken(_token);
        await _saveCurrentUser(jsonEncode(parsed['user']));
        await _saveMyProfile(jsonEncode(parsed['user']));
        return response;
      } else {
        return response;
      }
    });
  } */

  Future login(String identifier, String password) async {
    var res = {
      "jwt":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImlhdCI6MTcwNTkzNzQyNywiZXhwIjoxNzA4NTI5NDI3fQ.JYSsjtTzRSHu3W7afFLhE36vrsQwQCGHZyjAy6P_1Nw",
      "user": {
        "id": 17,
        "username": "910627594",
        "email": "ahmadtibin@gmail.com",
        "provider": "local",
        "confirmed": true,
        "blocked": false,
        "createdAt": "2022-06-21T22:43:34.980Z",
        "updatedAt": "2024-01-22T08:42:43.158Z",
        "phone": "910627594",
        "fullname": "Ahmed Ibrahim Tibin",
        "type": "Normal",
        "otp": null,
        "confirmedPhone": true
      }
    };
    var resencoded = jsonEncode(res);
    var parsed = jsonDecode(resencoded);
    _token = parsed['jwt'];
    _user = User.fromJson(parsed['user']);
    await _saveToken(_token);
    await _saveCurrentUser(jsonEncode(parsed['user']));
    await _saveMyProfile(jsonEncode(parsed['user']));
    return parsed;
  }

  Future<Response> register(String fullname, String username, String email,
      String phonenumber, String password, String code) async {
    Response response;
    return await _strapiLocalApi
        .register(fullname, username, email, phonenumber, password, code)
        .then((value) async {
      response = value;

      if (value.statusCode == 200) {
        var parsed = jsonDecode(response.body);
        _token = parsed['jwt'];
        _user = User.fromJson(parsed['user']);
        _profile = Profile.fromJson(parsed['user']);
        await _saveToken(_token);
        await _saveCurrentUser(jsonEncode(parsed['user']));
        await _saveMyProfile(jsonEncode(parsed['user']));
        return response;
      } else {
        return response;
      }
    });
  }

  _saveToken(String token) async {
    await _storageService.saveToken(token);
  }

  _saveCurrentUser(String user) async {
    await _storageService.saveCurrentUser(user);
  }

  _saveMyProfile(String profile) async {
    await _storageService.saveMyProfile(profile);
  }

  void _removeToken() {
    _storageService.removeToken();
  }

  void _removeCurrentUser() {
    _storageService.removeCurrentUser();
  }
}
