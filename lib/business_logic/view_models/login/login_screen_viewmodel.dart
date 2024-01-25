import 'dart:convert';
import 'package:bloomdeliveyapp/services/login/login_service_strapi.dart';
import 'package:flutter/foundation.dart';
import 'package:bloomdeliveyapp/business_logic/models/response/response_error_messages_model.dart';
import 'package:bloomdeliveyapp/business_logic/models/response/response_model.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';

class LoginScreenViewModel extends ChangeNotifier {
  bool isLoggedIn = false;
  bool saving = false;
  final LoginServiceStrapi _loginService = serviceLocator<LoginServiceStrapi>();

  List<ResponseErrorMeessagesModel> message = [];
  ResponseModel response = new ResponseModel();
  String errorMessage = '';
  void register(String fullname, String username, String email,
      String phonenumber, String password, String code) async {
    saving = true;
    notifyListeners();
    await _loginService
        .register(fullname, username, email, phonenumber, password, code)
        .then((value) {
      var parsed = jsonDecode(value.body);
      if (value.statusCode == 200) {
        this.isLoggedIn = true;
        saving = false;
        notifyListeners();
      } else if (value.statusCode == 400) {
        if (parsed['error']['message'] is List) {
          var messages = parsed['error']['message'];
          message =
              messages.map((e) => ResponseErrorMeessagesModel.fromJson(e));
        } else if (parsed['error']['message'] is Map) {
          this.message[0] =
              ResponseErrorMeessagesModel.fromJson(parsed['error']['message']);
        } else {
          errorMessage = parsed['error']['message'];
        }
        saving = false;
        notifyListeners();
        isLoggedIn = false;
      }
    });
  }

  void login(String identifier, String password) async {
    saving = true;
    notifyListeners();
    await _loginService.login(identifier, password).then((value) {
      isLoggedIn = true;
      saving = false;
      notifyListeners();
    });
  }

  /* void login(String identifier, String password) async {
    saving = true;
    notifyListeners();
    await _loginService.login(identifier, password).then((value) {
      var parsed = jsonDecode(value.body);
      if (value.statusCode == 200) {
        isLoggedIn = true;
      } else if (value.statusCode == 400) {
        if (parsed['error']['message'] is List) {
          var messages = parsed['error']['message'];
          message =
              messages.map((e) => ResponseErrorMeessagesModel.fromJson(e));
        } else if (parsed['error']['message'] is Map) {
          this.message[0] =
              ResponseErrorMeessagesModel.fromJson(parsed['error']['message']);
          //printError(message[0].message);
        } else {
          errorMessage = parsed['error']['message'];
          //printError(parsed['message']);
        }
        isLoggedIn = false;
      }
      saving = false;
      notifyListeners();
    });
  } */

  getFirstMessage() {
    if (message.isNotEmpty) {
      if (message[0].message!.isNotEmpty) {
        return message[0].message;
      }
    }
    return errorMessage;
  }
}
