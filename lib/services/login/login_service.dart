import 'package:http/src/response.dart';
import 'package:bloomdeliveyapp/business_logic/models/user/user_model.dart';

// This is the contract that all currency services must follow. Using an abstract
// class like this allows you to swap concrete implementations. This is useful
// for separating architectural layers. It also makes testing and development
// easier because you can provide a mock implementation or fake data.
abstract class LoginService {
  Future<User> getCurrentUser();
  Future<Response> login(String identifier, String password);
}
