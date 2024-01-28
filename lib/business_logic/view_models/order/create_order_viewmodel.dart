import 'dart:convert';

import 'package:bloomdeliveyapp/business_logic/models/response/response_error_messages_model.dart';
import 'package:bloomdeliveyapp/services/order/order_service_strapi.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum RideType {
  motorCycle,
  van,
}

class CreateOrderViewModel extends ChangeNotifier {
  bool isCreating = false;
  bool isCreated = false;
  String? error;

  List<LatLng> points = [];
  // receiver options step
  String? receiverName, receiverPhoneNumber, deliveryInstructions;
  // delivery options step
  RideType? rideType;
  double? fee;
  // goods selection step
  String? goods;


  final _orderService = serviceLocator<OrderServiceStrapi>();

  addReceiverInfo(String receiverName, String receiverPhone, String receiverInstruction) {
    this.receiverName = receiverName;
    this.receiverPhoneNumber = receiverPhone;
    this.deliveryInstructions = receiverInstruction;
    notifyListeners();
  }

  addDeliveryOption(RideType rideType, double price) {
    this.rideType = rideType;
    this.fee = price;
    notifyListeners();
  }

  addGoods(String goods) {
    this.goods = goods;
    notifyListeners();
  }

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
