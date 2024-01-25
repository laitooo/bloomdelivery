import 'package:flutter/foundation.dart';
import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';
import 'package:bloomdeliveyapp/services/service_locator.dart';
import 'package:bloomdeliveyapp/services/user/user_services.dart';

class UserMenuViewModel extends ChangeNotifier {
  bool loading = false;
  User? user;
  UserService _userService = serviceLocator<UserService>();

  getUser() async {
    loading = true;
    notifyListeners();
    _userService.getCurrentUser().then((user) {
      this.user = user;
      loading = false;
      notifyListeners();
    });
  }
}
