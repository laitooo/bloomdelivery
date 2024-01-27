import 'dart:convert';

import 'package:bloomdeliveyapp/business_logic/models/response/response_error_messages_model.dart';
import 'package:bloomdeliveyapp/services/order/order_service_strapi.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum RideType {
  motorCycle,
  van,
}

class CreateOrderViewModel extends ChangeNotifier {
  bool isCreating = false;
  bool isCreated = false;
  String? error;

  LatLng? start, end;
  String? receiverName, receiverPhoneNumber, instructions, goods;
  RideType? rideType;
  double? fee, tip;


  final _orderService = serviceLocator<OrderServiceStrapi>();

  void createRequest() async {
    isCreating = true;
    notifyListeners();
    await _orderService
        .createOrder(
            "fullname", "username", "email", "phonenumber", "password", "code")
        .then(
      (value) {
        var parsed = jsonDecode(value.body);
        if (value.statusCode == 200) {
          isCreated = true;
          isCreating = false;
          notifyListeners();
        } else if (value.statusCode == 400) {
          if (parsed['error']['message'] is List) {
            var messages = parsed['error']['message'];
            error =
                messages.map((e) => ResponseErrorMeessagesModel.fromJson(e));
          } else if (parsed['error']['message'] is Map) {
            error =
                ResponseErrorMeessagesModel.fromJson(parsed['error']['message'])
                    .message;
          } else {
            error = parsed['error']['message'];
          }
          isCreating = false;
          isCreated = false;
          notifyListeners();
        }
      },
    );
  }
}