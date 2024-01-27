import 'dart:convert';
import 'package:bloomdeliveyapp/business_logic/models/profile/profile_model.dart';

import 'package:bloomdeliveyapp/services/storage/local_storage_service.dart';
import 'package:http/src/response.dart';

import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/services/web_api/strapi_local_api.dart';

class OrderServiceStrapi {
  StrapiLocalApi _strapiLocalApi = serviceLocator<StrapiLocalApi>();

  Future<Response> createOrder(String fullname, String username, String email,
      String phonenumber, String password, String code) async {
    Response response;
    return await _strapiLocalApi
        .register(fullname, username, email, phonenumber, password, code)
        .then((value) async {
      response = value;

      return response;
    });
  }
}
